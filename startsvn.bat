@echo off
@rem 默认提取日志至当前目录 svn_log.txt
echo 提取日志....

@rem 定义变量
@rem svn项目地址
 set SVN_URL="http://183.3.136.39:83/svn/AICMBS/branches/code/aiccase_ws"
@rem svn版本开始，必须指定 取单个版本设置开始结束版本号一致
 set VERSION_START=676
@rem svn版本结束，必须指定，必须大于等于开始版本号
 set VERSION_END=676
@rem 用户密码暂不指定
 set USERNAME=
 set PASSWORD=
@rem 定义变量

 echo SVN_URL=%SVN_URL%
 echo VERSION_START=%VERSION_START%
 echo VERSION_END=%VERSION_END%
 echo USERNAME=%USERNAME%
 echo PASSWORD=%PASSWORD%


 if /I "%SVN_URL%"=="" goto :checkParam
 if /I "%VERSION_START%"=="" goto :checkParam
 if /I "%VERSION_END%"=="" goto :checkParam

 if %VERSION_START% gtr %VERSION_END% goto :checkParam
 if %VERSION_START% == %VERSION_END% goto :exportLog
 if not %VERSION_START% == %VERSION_END% goto :exportLog2

:checkParam
  echo 参数设置错误
  goto END

 @rem 输出日志至svn_log.txt文件
 @rem 输出日志内容
:exportLog
  svn log %SVN_URL% -v -r %VERSION_START% > ./svn_log.txt
  svn log %SVN_URL% -v -r %VERSION_START%
   call start.bat
  goto END

:exportLog2
  svn log %SVN_URL% -v -r %VERSION_START%:%VERSION_END% > ./svn_log.txt
  svn log %SVN_URL% -v -r %VERSION_START%:%VERSION_END%
   call start.bat
  goto END

:END
 echo 提取日志结束
 pause