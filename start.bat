@ECHO off

@REM �������
SET PYTHON_HOME="D:\Python\Python36-32"
@REM

IF NOT EXIST %PYTHON_HOME%\python.exe (
	ECHO  ERROR:The python.exe is not found.
	GOTO :END
)

@REM ��������
%PYTHON_HOME%\python.exe exporter.py
GOTO :END

:END
PAUSE