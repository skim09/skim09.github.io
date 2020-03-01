from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

from .models import Contactus

# Create your views here.
def index(request):
	return render(request, 'marketing/index.html', {})

def about(request):
	return render(request, 'marketing/about.html', {})

def contact(request):
	return HttpResponse("This is the contact us page.")

def order(request):
	return HttpResponse("This is the order page.")

def team(request):
	return render(request, 'marketing/team.html', {})

def services(request):
	return render(request, 'marketing/services.html', {})