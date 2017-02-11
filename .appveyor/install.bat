SET OPEN_SSL_BRANCH=OpenSSL_1_0_1-stable
SET LZMA_FILE=lzma920.tar.bz2

:: Create libraries folder
cd ..
mkdir Libraries
cd Libraries

:: OpenSSL
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout %OPEN_SSL_BRANCH%
perl Configure VC-WIN32 --prefix=D:\TBuild\Libraries\openssl\Release
ms\do_ms
nmake -f ms\nt.mak
nmake -f ms\nt.mak install
cd ..
dir

git clone https://github.com/openssl/openssl.git openssl_debug
cd openssl_debug
git checkout %OPEN_SSL_BRANCH%
perl Configure debug-VC-WIN32 --prefix=D:\TBuild\Libraries\openssl_debug\Debug
ms\do_ms
nmake -f ms\nt.mak
nmake -f ms\nt.mak install
cd ..
dir

:: LZMA SDK 9.20
curl -fsS -o %LZMA_FILE% http://downloads.sourceforge.net/sevenzip/%LZMA_FILE%
tar xaf %LZMA_FILE%
:: TODO Unzip lzma sdk

:: List libs
dir
