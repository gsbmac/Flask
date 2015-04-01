# from app import *
from backend import *
import sqlite3, hashlib
from flask import Flask, request, session, g, redirect, url_for, \
     abort, render_template, flash, redirect, escape
from contextlib import closing

# configuration
DATABASE = '/tmp/sample.db'
DEBUG = True
SECRET_KEY = 'sample'
USERNAME = 'root'
PASSWORD = 'user'

app = Flask(__name__)
app.config.from_object(__name__)
app.config.from_envvar('FLASKR_SETTINGS', silent=True)

def connect_db():
    return sqlite3.connect(app.config['DATABASE'])

def init_db():
    with closing(connect_db()) as db:
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

@app.before_request
def before_request():
    g.db = connect_db()

@app.teardown_request
def teardown_request(exception):
    db = getattr(g, 'db', None)
    if db is not None:
        db.close()


@app.route('/')
def index():
    if 'username' in session:
    	return redirect(url_for('home'))
    else:
    	return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
	params = {}
	cur = g.db.execute('select username, password from users order by id asc')
	users = [dict(username=row[0], password=row[1]) for row in cur.fetchall()]
	
	if 'username' in session:
		return redirect(url_for('home'))
	else:
	    if request.method == 'POST':

	    	params['username'] = request.form['username']
	    	params['password'] = hashlib.md5(request.form['password']).hexdigest()

	    	if (validate.validate_login(params, users)):
	        	session['username'] = params['username']
	        	return redirect(url_for('index'))
	        else:
	        	error = "Invalid username/password"
	        	return render_template('login.html', error=error)

	    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
	params = {}
	error = None

	if 'username' in session:
		return redirect(url_for('home'))
	else:
		cur = g.db.execute('select username, password from users order by id asc')
		users = [dict(username=row[0], password=row[1]) for row in cur.fetchall()]

		if request.method == 'POST':
			params['username'] = request.form['username']
			params['password'] = hashlib.md5(request.form['password']).hexdigest()

			if (validate.validate_signup(params, users)):
				error = "Username already taken"
				return render_template('signup.html', error=error)
			else:
				g.db.execute('insert into users (username, password) values (?, ?)', [params['username'], params['password']])
				g.db.commit()
				return redirect(url_for('index'))

		return render_template('signup.html', error=error)

@app.route('/delete/<username>')
def delete(username):
	if 'username' in session:
		g.db.execute('delete from users where username=?', [username])
		g.db.commit()
		return redirect(url_for('home'))

@app.route('/home')
def home():
	if 'username' in session:
		cur = g.db.execute('select * from logs where username=? order by start_date desc', [escape(session['username'])])
		logs = [dict(id=row[0], username=row[1], start_date=row[2], end_date=row[3], status=row[4]) for row in cur.fetchall()]
		return render_template('home.html', logs=logs)
	
	return redirect(url_for('index'))

@app.route('/logout')
def logout():
    # remove the username from the session if it's there
    session.pop('username', None)
    flash('You were logged out')
    return redirect(url_for('index'))

# set the secret key.  keep this really secret:
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

if __name__ == '__main__':
    app.run(debug=True)