@ECHO off

@REM 定义变量
SET PYTHON_HOME="D:\Python\Python36-32"
@REM

IF NOT EXIST %PYTHON_HOME%\python.exe (
	ECHO  ERROR:The python.exe is not found.
	GOTO :END
)

@REM 启动程序
%PYTHON_HOME%\python.exe exporter.py
GOTO :END

:END
PAUSE