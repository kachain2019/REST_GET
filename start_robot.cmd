@echo off
echo.
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
set year=%date:~-4%
set month=%date:~-10,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~-7,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%
set datetimef=%year%%month%%day%_%hour%%min%%secs%
echo ==============================================================================
goto run

:run
echo Robot:   Run tests
call move res res_%datetimef% >nul 2>nul
call robot --outputdir res --output output.xml --log NONE --report NONE .
echo ==============================================================================
if %errorlevel% equ 0 goto gen_report else goto rerun

:rerun
echo Robot:   Re-run failed tests
call robot --outputdir res --output output_rerun.xml --log NONE --report NONE --rerunfailed res\output.xml . 
echo ==============================================================================
goto merge

:merge
echo Rebot:   Merge output files
echo ==============================================================================
call rebot --outputdir res --output output.xml --log NONE --report NONE --merge res\output.xml res\output_rerun.xml
call del res\output_rerun.xml >nul 2>nul
echo ==============================================================================
goto gen_report

:gen_report
echo Rebot:   Generate log and report
echo ==============================================================================
call rebot --outputdir res res\output.xml
echo ==============================================================================
goto open_report

:open_report
call start res\report.html
goto:eof