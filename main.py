# from app import *
from backend import *
import sqlite3, hashlib
from flask import Flask, request, session, g, redirect, url_for, \
	 abort, render_template, flash, redirect, escape
from flaskext.mysql import MySQL

# configuration
mysql = MySQL()
app = Flask(__name__)
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'password'
app.config['MYSQL_DATABASE_DB'] = 'pr_db'
app.config['MYSQL_DATABASE_HOST'] = '127.0.0.1'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()

# @app.route('/')
# def index():
# 	cursor.execute("SELECT * from User where Username='" + username + "' and Password='" + password + "'")
#     data = cursor.fetchone()
#     if data is None:
#      return "Username or Password is wrong"
#     else:

@app.route('/')
def index():
	if 'username' in session:
		return redirect(url_for('home'))
	else:
		return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
	params = {}
	
	if 'username' in session:
		return redirect(url_for('home'))
	else:
		if request.method == 'POST':

			params['username'] = str(request.form['username'])
			params['password'] = str(hashlib.md5(request.form['password']).hexdigest())

			cursor.execute("SELECT * FROM tb_user WHERE username=%s AND password=%s", (params['username'], params['password']))
			data = cursor.fetchone()

			if data is None:
				error = "Invalid username/password"
				return render_template('login.html', error=error)
			else:
				session['username'] = params['username']
				return redirect(url_for('index'))

		return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
	params = {}
	error = None

	if 'username' in session:
		return redirect(url_for('home'))
	else:
		if request.method == 'POST':
			params['username'] = str(request.form['username'])
			params['password'] = str(hashlib.md5(request.form['password']).hexdigest())

			cursor.execute("SELECT * FROM tb_user WHERE username='" +params['username']+ "'")
			data = cursor.fetchone()

			if data is None:
				cursor.execute("INSERT INTO tb_user (username, password) VALUES (%s,%s)", (params['username'], params['password']))
				conn.commit()
				return redirect(url_for('index'))
			else:
				error = "Username already taken"
				return render_template('signup.html', error=error)
		
		return render_template('signup.html', error=error)

@app.route('/home')
def home():
	if 'username' in session:
		success = None
		category = request.args.get('category')
		cursor.execute('SELECT * FROM tb_user')
		users = [dict(id=row[0], username=row[1], password=row[2]) for row in cursor.fetchall()]

		cursor.execute("SELECT * FROM tb_category")
		categories = [dict(id=row[0], name=row[1], description=row[2]) for row in cursor.fetchall()]

		if 'success' in session:
			success = escape(session['success'])
			session.pop('success', None)
		return render_template('home.html', users=users, categories=categories, success=success)
	
	return redirect(url_for('index'))

@app.route('/home/delete/<id>')
def delete_user(id):
	if 'username' in session:
		cursor.execute("DELETE FROM tb_user WHERE id="+id)
		conn.commit()
		session['success'] = "User successfully deleted!"
		return redirect(url_for('home'))

	return redirect(url_for('index'))

@app.route('/category', methods=['GET', 'POST'])
def category():
	if 'username' in session:
		cursor.execute("SELECT * FROM tb_category")
		categories = [dict(id=row[0], name=row[1], description=row[2]) for row in cursor.fetchall()]

		# if request.method == 'POST':
		return render_template('category.html', categories=categories)

	return redirect(url_for('index'))

@app.route('/category/delete/<id>')
def delete_category(id):
	if 'username' in session:
		cursor.execute("DELETE FROM tb_category WHERE id=%d", int(id))
		conn.commit()
		return redirect(url_for('category'))

	return redirect(url_for('index'))

@app.route('/logout')
def logout():
	session.pop('username', None)
	flash('You were logged out')
	return redirect(url_for('index'))

# set the secret key.  keep this really secret:
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

if __name__ == '__main__':
	app.run(debug=True)