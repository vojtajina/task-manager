#!/usr/bin/env python

import webapp2
from google.appengine.api import users

import os
from google.appengine.ext.webapp import template
# import glob

# TODO(vojta): can we do the pre-auth ?
# ensure user is authenticated and gave permissions to task manager before loading the client ?
# redirects are easier to follow than pop-ups
class MainHandler(webapp2.RequestHandler):
    def get(self):
        user = users.get_current_user()

        # print os.listdir(os.path.join(os.path.dirname(__file__), 'app'))
        # os.chdir("/mydir")
        # x = glob.glob("app/*/*.js"):
          # print files

        if user:
            # self.response.headers['Content-Type'] = 'text/plain'
            # self.response.out.write('Hello, ' + user.nickname())
            path = os.path.join(os.path.dirname(__file__), 'index.html')
            # print path
            # template_values = {
            #     'scripts': ['one.js']
            # }
            self.response.out.write(template.render(path, {}))
        else:
            self.redirect(users.create_login_url(self.request.uri))

app = webapp2.WSGIApplication([('/', MainHandler)],
                              debug=True)
