@echo off

call project.bat

set BuildFolder=built
set ExternalPath=external

if /i "%1"=="release" (
	set Config=release
	set ConfigCompilerOptions=/MT /O2 /Oi /Oy /GL /wd4189
	set ConfigLinkerOptions=/opt:ref
) else (
	set Config=debug
	set ConfigCompilerOptions=/MTd /Od
	set ConfigLinkerOptions=/opt:noref /debug
)

set CommonCompilerFlags=%ConfigCompilerOptions% /nologo /fp:fast /Gm- /GR- /EHsc /WX /W4 /FC /Z7 /D_CRT_SECURE_NO_WARNINGS /I%ExternalPath% /Fo%BuildFolder%\
set CommonLinkerFlags=%ConfigLinkerOptions% /incremental:no /subsystem:console d3d11.lib d3dcompiler.lib dxguid.lib ole32.lib

if not exist %BuildFolder%\ mkdir %BuildFolder%

echo Compiling: %ProjectExe%, Config: %Config%

cl.exe %CommonCompilerFlags% source/win32_main.cpp /Fe%BuildFolder%/%ProjectExe% /link %CommonLinkerFlags%
