from django.shortcuts import render_to_response
from django.http import HttpResponse, Http404
from warmup_apps.models import UserData
from django.template import Context, loader, RequestContext
from django.views.decorators.csrf import csrf_exempt, csrf_protect
import sys
import json

empty = UserData()


@csrf_exempt
def index(request):
	if request.method=="GET":
		if request.path in ["/client.html","/client.css","/client.js"]:
			mime_type="text/html"
			if request.path.endswith(".css"):
				mime_type = "text/css"
			elif request.path.endswith(".js"):
				mime_type = "text/javascript"
			return render_to_response('admin'+request.path,mimetype=mime_type)
		else:
			raise Http404
	elif request.method=="POST":
		if request.path == "/TESTAPI/resetFixture":
			errorcode = empty.resetFixture()
			return HttpResponse(json.dumps({'errCode':errorcode}),content_type="application/json" )
		elif request.path == "/TESTAPI/unitTests":
			test = empty.unitTests()
			return HttpResponse(json.dumps(test),content_type="application/json")
			
		else:	
			return do(request)
	else:
		raise Http404


@csrf_exempt
def do(request):
	user = json.loads(request.body)

	if request.path=="/users/login":
		errorcode = empty.login(user["user"], user["password"])
	elif request.path=="/users/add":
		errorcode = empty.add(user["user"], user["password"])
	if (errorcode==1):
		u = UserData.objects.get(username = user["user"])
		return HttpResponse(json.dumps({'errCode': errorcode, 'count': u.count}),content_type="application/json")
	else:
		return HttpResponse(json.dumps({'errCode': errorcode}),content_type="application/json" )

