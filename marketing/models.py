from django.db import models

# Create your models here.
class Contactus(models.Model):
  user_name = models.CharField(max_length=70)
  user_email = models.CharField(max_length=255)
  subject_text = models.CharField(max_length=20)
  email_text = models.CharField(max_length=5000)
    
class SummiesOrder(models.Model):
	user_name = models.CharField(max_length=70)
	user_number = models.BigIntegerField()
	user_location = models.CharField(max_length=50)
	price = models.FloatField(max_length=6)
	ordertext = models.CharField(max_length=300)

class WesWingsOrder(models.Model):
	user_name = models.CharField(max_length=70)
	user_number = models.BigIntegerField()
	user_location = models.CharField(max_length=50)
	price = models.FloatField(max_length=6)
	ordertext = models.CharField(max_length=300)