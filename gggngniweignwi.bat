��

@echo off
chcp 65001 > nul 2>&1
cls
title Persona 4 Golden Việt hóa
    echo Persona 4 Golden © SEGA/ATLUS. Persona 4 Golden Việt hóa là một dự án cộng đồng
    echo không có bất cứ mối liên hệ nào tới nhà phát hành/nhà phát triển.
    echo Việt hóa bởi kecox15670. Nếu bạn đã mua bản Việt hóa này từ ai đó, chắc chắn là bạn đã bị lừa đảo.
    echo -------------------------------------- 
    echo Trước khi cài Việt hóa, bạn nên chạy trình cài đặt này với quyền Administrator, đây không phải
    echo bắt buộc, nhưng bạn nên làm vậy để tránh bị lỗi nhất có thể.
	echo Nhấn phím bất kỳ để tiếp tục.
pause >nul
    pushd "%CD%"
cls
    CD /D "%~dp0"

:exe_check
if exist P4G.exe (
cls
goto md5_check
cls
) else (
MODE 87,10
echo Không tìm được tệp tin thực thi của Persona 4 Golden (P4G.exe^). Vui lòng kiểm tra xem
echo tệp tin p4gvh.bat có được đặt cùng P4G.exe hay không.
echo Bấm phím bất kỳ để thoát.
pause > nul
exit
)

:md5_check
start /wait /min tools/md5.exe -n -op4gmd5.txt -i P4G.exe
set /p p4gmd5=<p4gmd5.txt
del p4gmd5.txt > nul 2>&1
if "%p4gmd5%" EQU "A215C43DBD37C5F8F5703B24924F2124" (
goto ask_for_update
) else (
MODE 87,10
echo Phiên bản Persona 4 Golden của bạn không tương thích với bản Việt hóa này.
echo Trình cài đặt này chỉ sử dụng được cho bản Steam.
echo Bấm phím bất kỳ để thoát.
pause > nul
exit
)
	
:ask_for_update
MODE 87,10
cls
if not exist reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll (
	ping google.com -n 1 -w 1000 > nul 2>&1
	cls
	if errorlevel 1 (
	echo Vì đây là lần chạy đầu tiên, bạn cần phải kết nối mạng để tải mod Việt hóa.
	echo Hãy chắc chắn rằng bạn đã kết nối mạng.
	echo Nhấn phím bất kỳ để thoát.
	pause>nul
	exit
	) else (
	goto first_launch
	)
) else (
	Setlocal EnableDelayedExpansion
	echo Bạn có muốn kiểm tra cập nhật?
	choice /c YN /n /m "Nhấn Y để chấp nhận, hoặc nhấn N để từ chối."
	if !errorlevel! EQU 2 (
		goto main_steam
	)
	goto update_check
)

:first_launch
echo Đang tải mod Việt hóa (Core^)...
chcp 437 > nul 2>&1
powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/work/uwihw8ah4pVV-core.zip -OutFile uwihw8ah4pVV-core.zip"
chcp 65001 > nul 2>&1

:update_check
set batchVersion=1.0
del batchLatestVer.txt > nul 2>&1
curl -o batchLatestVer.txt https://raw.githubusercontent.com/KoAiBitTuiLaAi/gnugnugbu/main/gggngniweignwi/wuauadbubaw.txt > nul 2>&1
set /p batchLatestVer=<batchLatestVer.txt
title Trình cài đặt Persona 4 Golden Việt hóa - Cập nhật
echo Đang kiểm tra cập nhật cho trình cài đặt...

if "%batchLatestVer%" GTR "%batchVersion%" (
    echo Đang cập nhật trình cài đặt...
	timeout /t 3 > nul
    curl -o "%~f0.tmp" https://raw.githubusercontent.com/KoAiBitTuiLaAi/gnugnugbu/main/gggngniweignwi.bat > nul 2>&1
    move /y "%~f0.tmp" "%~f0" > nul 2>&1
) else (
	echo Trình cài đặt đang ở phiên bản mới nhất.
	echo Bắt đầu kiểm tra mod...
	timeout /t 3 > nul
	goto content_check
)

:content_check
chcp 437 > nul 2>&1
for /f "delims=" %%g in ('powershell "((Invoke-RestMethod https://api.github.com/repos/KoAiBitTuiLaAi/gnugnugbu/releases/latest -timeout 2).body.Split("\"`n"\") | Select-String -Pattern 'build tag:') -replace  'build tag: '"') do @set git_version=%%g
if exist reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll (
   for /f "delims=" %%v in ('powershell "((Get-Item reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll).VersionInfo.FileVersion) -replace '1.0.0.'"') do @set version=%%v
   chcp 65001 > nul 2>&1
)
set boot=0
chcp 65001 > nul 2>&1

if not exist uwihw8ah4pVV-latest.zip (
    echo Kiểm tra cập nhật mod Việt hóa...
    if "%version%" EQU "%git_version%" (
	    echo Mod Việt hóa số %version% là phiên bản mới nhất!
		pause
		goto main_steam
	) else (
		if exist reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll (
			if "%version%" NEQ "" (
				echo Phiên bản %version% của bạn đang là phiên bản cũ.
			) else (
				echo Không thể xác định phiên bản Việt hóa bạn đang có.
			)
		) else (
			Setlocal EnableDelayedExpansion
			echo Mod Việt hóa chưa được tải đầy đủ, bạn có muốn tiếp tục?
			choice /c YN /n /m "Nhấn Y để chấp nhận, hoặc nhấn N để hủy."
			if !errorlevel! EQU 2 (
				echo Quá trình tải về đã bị hủy.
				echo Nhấn phím bất kỳ để thoát.
				pause>nul
				exit
			)
		)
		echo Đang tải về và giải nén phiên bản %git_version%...
		chcp 437 > nul 2>&1
		powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/work/uwihw8ah4pVV-latest.zip -OutFile uwihw8ah4pVV-latest.zip"
		chcp 65001 > nul 2>&1
	)
) else (
	set boot=1
)

if exist uwihw8ah4pVV-latest.zip (
	echo Đã tải xong, đang giải nén nội dung...
	chcp 437 > nul 2>&1
	powershell "Expand-Archive -Force -Path uwihw8ah4pVV-latest.zip -DestinationPath '.'"
	del uwihw8ah4pVV-latest.zip
	chcp 65001 > nul 2>&1
	if "%version%" NEQ "" (
		echo Đã cập nhật xong gói nội dung từ phiên bản %version% lên phiên bản %git_version%!
	) else (
		echo Mod Việt hóa phiên bản %git_version% đã tải thành công!
	)
	if %boot% EQU 1 (
		echo Đến quá trình cài đặt...
	) else (
		echo Bây giờ bạn đã có thể chạy Persona 4 Golden với bản Việt hóa mới nhất.
		echo Nhấn phím bất kỳ để trở về màn hình chính.
		pause > nul
		goto main_steam
	)
) else if %boot% EQU 0 (
	echo Quá trình tải về đã thất bại, xin hãy chạy lại trình cài đặt.
	echo Nếu lỗi này vẫn xảy ra, hãy báo lỗi cho mình biết trong Discord hoặc trong diễn đàn.
)

if %boot% EQU 0 (
	echo Bấm phím bất kỳ để thoát.
	pause > nul
	exit
)

REM :windows_check
REM cls

REM :moddata_check
REM setlocal

REM set allfound=no
REM if exist batch if exist ModData set allfound=yes
REM if "%allfound%"=="yes" (
REM cls
REM goto store_check
REM cls
REM ) else (
REM echo Không tìm được tệp tin mod Việt hóa, tệp tin mod Việt hóa bao gồm thư mục batch và ModData. Vui lòng kiểm tra lại xem 2 thư mục này có được đặt cùng bf4.exe hay không.
REM echo Bấm phím bất kỳ để thoát.
REM pause > nul
REM exit
REM )

REM endlocal

REM :store_check
REM setlocal

REM if exist __overlay\steam_api.dll  (
REM cls
REM goto steam_check
REM cls
REM ) else (
REM goto origin_check
REM cls
REM )

REM endlocal

REM :steam_check
REM if exist ModData\k9_warsaw_vie\Data (
REM cls
REM goto main_steam_installed
REM cls
REM ) else (
REM goto main_steam
REM cls
REM )

:main_steam
MODE 120,30
chcp 437 > nul 2>&1
set /p batchLatestVer=<batchLatestVer.txt
for /f "delims=" %%v in ('powershell "((Get-Item reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll).VersionInfo.FileVersion) -replace '1.0.0.'"') do @set version=%%v
call batch\main_steam.bat
echo Số phiên bản của trình cài đặt: %batchLatestVer%
echo Phiên bản mod: %version%
echo Vui lòng chọn:
echo 1. Cài mod Việt hóa
echo 2. Truy cập diễn đàn forum_name_placeholder
echo 3. Thoát
set chon=
set /p chon=Nhập số: 
if not '%chon%'=='' set chon=%chon:~0,1%
if '%chon%'=='1' goto k8_prereq_steam
if '%chon%'=='2' goto forum
if '%chon%'=='3' goto thoat
echo Bạn chưa chọn gì cả.
timeout /t 10
goto main_steam

REM :launch_warsaw_vie_selection
REM title Trình cài đặt Persona 4 Golden Việt hóa - KHỞI CHẠY PERSONA 4 GOLDEN
REM cls
REM echo Bạn muốn chạy bản Steam hay EA app/Origin?
REM echo Vui lòng chọn:
REM echo 1. Steam
REM echo 2. EA (Origin)
REM echo 3. Quay lại
REM set chon=
REM set /p chon=Nhập số: 
REM if not '%chon%'=='' set chon=%chon:~0,1%
REM if '%chon%'=='1' goto launch_warsaw_vie_steam
REM if '%chon%'=='2' goto launch_warsaw_vie_origin
REM if '%chon%'=='3' goto main
REM echo Bạn chưa chọn gì cả.
REM timeout /t 10
REM goto launch_warsaw_vie_selection

REM :launch_warsaw_vie_steam
REM if exist ModData\k9_warsaw_vie\Data (
REM cls
REM start batch\warsaw_singleplayer_steam.bat
REM exit
REM ) else (
REM echo Bạn chưa cài mod Việt hóa.
REM timeout /t 15
REM goto main
REM )

REM :storeselect
REM title Trình cài đặt Persona 4 Golden Việt hóa - CHỌN NỀN TẢNG
REM cls
REM echo Bạn muốn cài mod Việt hóa cho bản Steam hay EA app/Origin?
REM echo Vui lòng chọn:
REM echo 1. Steam
REM echo 2. EA (Origin)
REM echo 3. Quay lại
REM set chon=
REM set /p chon=Nhập số: 
REM if not '%chon%'=='' set chon=%chon:~0,1%
REM if '%chon%'=='1' goto warsaw_prereq_steam
REM if '%chon%'=='2' goto warsaw_prereq_origin
REM if '%chon%'=='3' goto main
REM echo Bạn chưa chọn gì cả.
REM timeout /t 10
REM goto storeselect

REM :storeselect_uninstall
REM cls
REM title Whoa there, bucko!
REM cls
REM echo Tính năng này hiện không khả dụng.
REM echo Nhấn phím bất kỳ để trở lại.
REM timeout /t -1 > nul
REM goto main

:k8_prereq_steam
cls
title Trình cài đặt Persona 4 Golden Việt hóa - ĐANG CÀI
cls
echo Đang cài... Vui lòng đợi.
call batch\run_pre.bat > nul
call batch\run_apps.bat > nul
title Trình cài đặt Persona 4 Golden Việt hóa - ĐÃ CÀI XONG
cls
echo Đã cài xong!
timeout /t 10
goto main_steam

:forum
cls
title Whoa there, bucko!
cls
echo Tính năng này hiện không khả dụng.
echo Nhấn phím bất kỳ để trở lại.
timeout /t -1 > nul
goto main

:thoat
exit