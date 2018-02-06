#####################################################################################
#                                                                                   #
#  Script to start client application                                               #
#                                                                                   #
#  Usage : wsadmin -lang jython -f startApplication.py name                         # 
#                                                                                   #
#####################################################################################

def startApplication(name):
	
	appManager = AdminControl.queryNames('node=DefaultNode01,type=ApplicationManager,process=server1,*')
	AdminControl.invoke(appManager, 'startApplication', name)

startApplication(sys.argv[0])
