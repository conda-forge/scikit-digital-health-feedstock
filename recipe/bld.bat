%PYTHON% -m pip install . -vv
bash -lc ./build.sh
if %errorlevel% neq 0 exit /b %errorlevel%
exit /b 0
