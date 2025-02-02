::Sebastian Marin 2025
::Do with this whatever you want unless you make
::money with it. In that case, idk, it IS just a batch file.
::https://github.com/cyanwaves-audio/

@echo off

::setup text colors
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

call :ColorText B "Welcome to the 'GodDammitFork' utility"

::REPLACE with path to your local copy of the repo
cd /d "C:\...\... ...\YourRepo"

::===================================

echo/
echo/
call :ColorText 3 "Running Git status"
echo/

:: run git status and check if working tree is clean
set dirty=0
for /f "delims=" %%i in ('git status --porcelain') do (
    set dirty=1
)

echo/

if !dirty! == 1 (
    call :statusdirty
) else (
    call :statusclean
	
)
goto :eof


:statusdirty
	call :ColorText 4 "Working Tree dirty (unstaged and/or staged files)."
	echo/
	call :ColorText 3 "Closing."
	echo/
	timeout /t 10
goto :eof


:statusclean
	for /f "delims=" %%i in ('git log -1 --date=format:"%%d-%%m-%%Y | %%H:%%M" --pretty^="%%s // Date: %%cd"') do set COMMIT_MSG=%%i
	echo/
	call :ColorText 4 "Working Tree clean. You can proceed."
	echo/
	echo/
	goto :undocommit
goto :eof


:undocommit
	echo/
	echo/

	call :ColorText 6 "Undo last commit ^?"

	choice /c YN 
	if %ERRORLEVEL% EQU 1 goto do_undo	
	if %ERRORLEVEL% EQU 2 goto end

:do_undo
	git reset --soft HEAD~
	echo/
	call :ColorText B "Last commit undone."
	echo/
	call :ColorText B "Commit files have been Staged."
	echo/
	echo/

	call :ColorText 6 "Save changes to new stash ^?"
	choice /c YN
	if %ERRORLEVEL% EQU 1 goto dostash
	if %ERRORLEVEL% EQU 2 goto endstaged
	echo/
	timeout /t 10
goto :eof


:endstaged
	echo/
	call :ColorText B "Modified files remain Staged."
	echo/
	call :ColorText B "Closing."
	echo/
	timeout /t 10
goto :eof


:dostash
	echo/
	call :ColorText 4 "Saving, please wait."
	echo/
	git stash push -m "%COMMIT_MSG%"
	git reset --hard
	echo/
	call :ColorText B "Files saved to new stash."
	echo/
	call :ColorText B "Closing."
	echo/
	timeout /t 10
goto :eof



:end
	echo/
	call :ColorText B "No changes."
	echo/
	call :ColorText B "Closing."
	echo/
	timeout /t 10
goto :eof


::text color
:ColorText
	rem echo off
	<nul set /p ".=%DEL%" > "%~2"
	findstr /v /a:%1 /R "^$" "%~2" nul
	del "%~2" > nul 2>&1
goto :eof

