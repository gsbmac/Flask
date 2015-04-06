def validate_login(params, users):

	for user in users:
		if (params['username'] == user['username'] and params['password'] == user['password']):
			return True

	return False

def validate_signup(params, users):

	for user in users:
		if (params['username'] == user['username']):
			return True

	return False