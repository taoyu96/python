import os
import os.path 
import shutil 

class mavenCreater(object):
	"""docstring for ClassName"""

	copyList = []

	# 初始化
	def __init__(self, sourcePath, destPath = "temp/production" , txtPath = "svn_log.txt"):
		self.sourcePath = sourcePath
		self.destPath = destPath
		self.txtPath = txtPath


	# 检查配置	
	def checkConfig(self):
		if not os.path.exists(self.sourcePath):
			print("源文件目录不存在sourcePath>>",self.sourcePath)
			return False
		if not os.path.isfile(self.txtPath):
			print("日志文件不存在txtPath>>",self.txtPath)
			return False
		if not self.destPath:
			print("导出路径为空")
			return False

		resetDir(self.destPath)	# 重置导出路径

		print("sourcePath>>",self.sourcePath)
		print("destPath>>",self.destPath)
		print("txtPath>>",self.txtPath)			
		return True

	# 读取日志文件
	def readSvnFile(self):
		fp = open(self.txtPath, "r")
		list = fp.readlines()
		fp.close()
		#print(list)
		for path in list:
			#path.strip()
			if "/src/main/" in path and "." in path and "D /" not in path:
				path = path.replace("\n", "")
				if "(from" in path:
					index = path.rfind("(from")
					path = path[0:index]
				if "/main/java/" in path: 
					if ".java" in path:
						path = path.replace(".java", ".class")
					index = path.rfind("/main/java/")
					path = "/WEB-INF/classes/"+path[index+11:]
				if "/main/resources/" in path:
					index = path.rfind("/resources/")
					path = "/WEB-INF/classes/"+path[index+11:]
				if "/main/webapp/" in path:
					index = path.rfind("/webapp/")
					path = path[index+7:]
				mavenCreater.copyList.append(path)	
				print("读取>> ",path)

	# 导出文件	
	def createFile(self):
		if mavenCreater.copyList:
			for str in  mavenCreater.copyList:
				sourcePath = self.sourcePath + str
				destPath  = self.destPath + str
				sourceDir = os.path.dirname(sourcePath)
				destDir = os.path.dirname(destPath)
				fileName = os.path.split(destPath)[-1]
				if not os.path.exists(destDir):
					os.makedirs(destDir)
				if ".class" in fileName: #处理内部类
					temp = os.path.splitext(fileName)[0]
					list = os.listdir(sourceDir)
					for file in os.listdir(sourceDir):
						if temp + "$" in file:
							if os.path.isfile(os.path.join(sourceDir,file)):
								shutil.copy(os.path.join(sourceDir,file), os.path.join(destDir,file))
				if os.path.isfile(sourcePath):			
					shutil.copy(sourcePath, destPath)
				print("成功创建>> ",str)
		else:
			print("尚未检测到需要导出的文件")

def resetDir(targetDir):
	if os.path.exists(targetDir):
		shutil.rmtree(targetDir)
	else:
		os.makedirs(targetDir)

if __name__ == '__main__':
	_creater = mavenCreater("E:/chinaweal/AICMBS/aiccase_ws/target/aiccase-1.0-SNAPSHOT")
	if _creater.checkConfig():
		print("校验成功")
		_creater.readSvnFile()
		_creater.createFile()
	else:
		print("配置不正确，请检查")
	print("运行结束")