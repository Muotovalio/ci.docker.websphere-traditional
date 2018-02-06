#####################################################################################
#                                                                                   #
#  Script to stop client application                                               #
#                                                                                   #
#  Usage : wsadmin -lang jython -f stopApplication.py name                         # 
#                                                                                   #
#####################################################################################

def stopApplication(name):
	
	appManager = AdminControl.queryNames('node=DefaultNode01,type=ApplicationManager,process=server1,*')
	AdminControl.invoke(appManager, 'stopApplication', name)

stopApplication(sys.argv[0])
