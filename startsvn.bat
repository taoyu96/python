@echo off
@rem Ĭ����ȡ��־����ǰĿ¼ svn_log.txt
echo ��ȡ��־....

@rem �������
@rem svn��Ŀ��ַ
 set SVN_URL="http://183.3.136.39:83/svn/AICMBS/branches/code/aiccase_ws"
@rem svn�汾��ʼ������ָ�� ȡ�����汾���ÿ�ʼ�����汾��һ��
 set VERSION_START=676
@rem svn�汾����������ָ����������ڵ��ڿ�ʼ�汾��
 set VERSION_END=676
@rem �û������ݲ�ָ��
 set USERNAME=
 set PASSWORD=
@rem �������

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
  echo �������ô���
  goto END

 @rem �����־��svn_log.txt�ļ�
 @rem �����־����
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
 echo ��ȡ��־����
 pause