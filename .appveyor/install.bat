SET BUILD_DIR=C:\TBuild
SET OPEN_SSL_BRANCH=OpenSSL_1_0_1-stable
SET LZMA_VERSION=lzma920

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

    call "C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.cmd" /x86
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
    call ms\do_ms
    nmake -f ms\nt.mak
    nmake -f ms\nt.mak install
    cd ..

    git clone https://github.com/openssl/openssl.git openssl_debug
    cd openssl_debug
    git checkout %OPEN_SSL_BRANCH%
    perl Configure debug-VC-WIN32 --prefix=%BUILD_DIR%\Libraries\openssl_debug\Debug
    call ms\do_ms
    nmake -f ms\nt.mak
    nmake -f ms\nt.mak install
    cd ..
GOTO:EOF

:getLZMA
    echo Get lzma sdk
    powershell -Command "Invoke-WebRequest http://7-zip.org/a/%LZMA_VERSION%.tar.bz2 -OutFile %LZMA_VERSION%.tar.bz2"
	7z x %LZMA_VERSION%.tar.bz2
	7z x %LZMA_VERSION%.tar -olzma
    dir
GOTO:EOF
