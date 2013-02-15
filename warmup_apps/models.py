from django.db import models
from testAdditional import Tests
import StringIO
import unittest

# Create your models here.

SUCCESS = 1                # a success
ERR_BAD_CREDENTIALS = -1   # (for login) cannot find the user/password pair in the database
ERR_USER_EXISTS = -2       # (for add) trying to add a user that already exists
ERR_BAD_USERNAME = -3      # (for add) invalid user name (user name should be non-empty and at most 128 ascii characters long)
ERR_BAD_PASSWORD = -4      # (for add) invalid password (password should be at most 128 ascii characters)
MAX_LENGTH=128

class UserData(models.Model):
	username = models.TextField(max_length=128)
        password = models.TextField(max_length=128)
	count = models.IntegerField()

	def checkUser(self, name):
		try: 
			value = UserData.objects.get(username = name)
		except:
			value = None
		return value

	def validate(self, name, psd):
		#if username doesn't match requirement, return BAD_USERNAME
		if (len(name)>MAX_LENGTH or len(name)==0):
			return (False, ERR_BAD_USERNAME)
		#if password doesn't match requirement, return BAD_PASSWORD
		if (len(psd)>MAX_LENGTH):
			return (False, ERR_BAD_PASSWORD)
		else:
			return (True, SUCCESS)
		

	def login(self, name, psd):
		valid = self.validate(name, psd)
		if not valid[0]:
			return ERR_BAD_CREDENTIALS

		recorded_user = self.checkUser(name)
		#if user not in database
		if recorded_user==None:        
			return ERR_BAD_CREDENTIALS

		#if user in database and password is correct
		if (recorded_user.password == psd):
			recorded_user.count+=1
			recorded_user.save()
			return SUCCESS
		#else, password is wrong
		else: 
			return ERR_BAD_CREDENTIALS


	def add(self, name, psd):
		valid = self.validate(name, psd)
		if not valid[0]:
			return valid[1]


		recorded_user = self.checkUser(name)
		#if user in database, return USER_EXISTS
		if(recorded_user != None):
			return ERR_USER_EXISTS
	
		#otherwise, add user into database
		newUser = UserData(username=name, password=psd, count=1)
		newUser.save()
		return SUCCESS

	def resetFixture(self):
		UserData.objects.all().delete()
		return SUCCESS

	def unitTests(self):
		buf = StringIO.StringIO()
		suite = unittest.TestLoader().loadTestsFromTestCase(Tests)
		result = unittest.TextTestRunner(stream = buf, verbosity = 2).run(suite)

		return {"totalTests": result.testsRun, "nrFailed": len(result.failures), "output": buf.getvalue()}

