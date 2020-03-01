from django.conf.urls import url

from . import views

urlpatterns = [
	# ex: /
	url(r'^$', views.index, name='index'),
	# ex: /about/
	url(r'^about/$', views.about, name='about'),
	# ex: /contact/
	url(r'^contact/$', views.contact, name='contact'),
	# ex: /order/
	url(r'^order/$', views.order, name='order'),
	# ex: /team/
	url(r'^team/$', views.team, name='team'),
	# ex: /services/
	url(r'^services/$', views.services, name='services')
]


