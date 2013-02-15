import os
import sys


#sys.path.append('salty-castle-4218.herokuapp.com/')
#sys.path.append('/home/ubuntu/')
os.environ['DJANGO_SETTINGS_MODULE'] = "warmup_proj.settings"

"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.
"""

from django.test import TestCase


class SimpleTest(TestCase):
    def test_basic_addition(self):
        """
        Tests that 1 + 1 always equals 2.
        """
        self.assertEqual(1 + 1, 2)
