SET BUILD_DIR=C:\TBuild
SET OPEN_SSL_BRANCH=OpenSSL_1_0_1-stable
SET LZMA_FILE=lzma920.tar.bz2

call:installUtils
call:createLibsFolder
call:getOpenSSL
call:getLZMA

echo Install completed

GOTO:EOF

:: List libs
dir

:: FUNCTIONS

:installUtils
    echo Install utils
    choco install -y curl 7zip

    if not "%VSVER%" == "" call "C:\Program Files (x86)\Microsoft Visual Studio %VSVER%.0\VC\vcvarsall" x86
    set PATH=%PATH%;"C:\Program Files\7-Zip";%TOOLSDIR%\bin
GOTO:EOF

:createLibsFolder
    echo Create libs folder
    cd ..
    mkdir Libraries
    cd Libraries
GOTO:EOF

:getOpenSSL
    echo Get open ssl
    git clone https://github.com/openssl/openssl.git
    cd openssl
    git checkout %OPEN_SSL_BRANCH%
    perl Configure VC-WIN32 --prefix=%BUILD_DIR%\Libraries\openssl\Release
    :: TODO this is failing
    ::ms\do_ms
    ::nmake -f ms\nt.mak
    ::nmake -f ms\nt.mak install
    cd ..
    dir

    git clone https://github.com/openssl/openssl.git openssl_debug
    cd openssl_debug
    git checkout %OPEN_SSL_BRANCH%
    perl Configure debug-VC-WIN32 --prefix=%BUILD_DIR%\Libraries\openssl_debug\Debug
    :: TODO this is failing
    ::ms\do_ms
    ::nmake -f ms\nt.mak
    ::nmake -f ms\nt.mak install
    cd ..
    dir
GOTO:EOF

:getLZMA
    echo Get lzma sdk
    powershell -Command "Invoke-WebRequest http://downloads.sourceforge.net/sevenzip/%LZMA_FILE% -OutFile %LZMA_FILE%"
    dir
    :: TODO Unzip lzma sdk
GOTO:EOF
