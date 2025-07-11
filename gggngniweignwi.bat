��

@echo off
chcp 65001 > nul 2>&1
cls
title Persona 4 Golden Việt hóa
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
cls
    echo Persona 4 Golden © SEGA/ATLUS. Persona 4 Golden Việt hóa là một dự án cộng đồng
    echo không có bất cứ mối liên hệ nào tới nhà phát hành/nhà phát triển.
    echo Việt hóa bởi kecox15670. Đây là một bản mod hoàn toàn miễn phí, nếu bạn đã mua bản
	echo Việt hóa này từ ai đó, bạn đã bị lừa đảo.
    echo -------------------------------------- 
    echo Trước khi cài Việt hóa, bạn nên chạy trình cài đặt này với quyền Administrator, đây không phải
    echo bắt buộc, nhưng bạn nên làm vậy để tránh bị lỗi nhất có thể. Nếu đây là lần chạy đầu tiên, bạn
	echo cần phải bật mạng để tải nội dung về.
	echo Nhấn phím bất kỳ để tiếp tục cài đặt mà không chạy với quyền Administrator.
pause >nul
    goto arch_check
) else ( goto gotAdmin )

:gotAdmin
    pushd "%CD%"
cls
    CD /D "%~dp0"
:--------------------------------------    

:arch_check
if %PROCESSOR_ARCHITECTURE%==x86 (
	cls
	echo P4G Việt hóa yêu cầu hệ điều hành 64-bit.
	echo Vui lòng cài đặt Windows bản 64-bit.
	echo Nhấn phím bất kỳ để thoát.
	pause>nul
	exit
)

:tools_check
cls
where PowerShell >nul 2>&1 || (
    echo Không thể tìm thấy PowerShell trong máy. Xin hãy cài hoặc bật tính năng PowerShell.
	echo Nhấn phím bất kỳ để thoát.
	pause>nul
	exit
)
echo Đang tải công cụ cài đặt...
chcp 437 > nul 2>&1
mkdir tools > nul 2>&1
if not exist tools\7z.exe powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/7z.exe -OutFile tools/7z_part.exe" || goto first_launch_download_failed
powershell Rename-Item "tools/7z_part.exe" "7z.exe" > nul 2>&1
if not exist tools\7z.dll powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/7z.dll -OutFile tools/7z_part.dll" || goto first_launch_download_failed
powershell Rename-Item "tools/7z_part.dll" "7z.dll" > nul 2>&1
if not exist tools\md5.exe powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/md5.exe -OutFile tools/md5_part.exe" || goto first_launch_download_failed
powershell Rename-Item "tools/md5_part.exe" "md5.exe" > nul 2>&1
if not exist tools\wget.exe powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/wget.exe -OutFile tools/wget_part.exe" || goto first_launch_download_failed
powershell Rename-Item "tools/wget_part.exe" "wget.exe" > nul 2>&1
chcp 65001 > nul 2>&1

:update_check
MODE 120,30
title Trình cài đặt Persona 4 Golden Việt hóa - Cập nhật
echo Đang kiểm tra cập nhật cho trình cài đặt...
set batchVersion=1.3
del batchLatestVer.txt > nul 2>&1
"tools/wget.exe" -O batchLatestVer.txt https://raw.githubusercontent.com/KoAiBitTuiLaAi/gnugnugbu/main/gggngniweignwi/wuauadbubaw.txt > nul 2>&1 || goto update_check_download_failed
set /p batchLatestVer=<batchLatestVer.txt

if "%batchLatestVer%" GTR "%batchVersion%" (
    echo Đang cập nhật trình cài đặt...
	timeout /t 3 > nul
    "tools/wget.exe" -O "p4gvh_%batchLatestVer%.bat" https://raw.githubusercontent.com/KoAiBitTuiLaAi/gnugnugbu/main/gggngniweignwi.bat > nul 2>&1 || goto update_check_download_failed
	start p4gvh_%batchLatestVer%.bat
	(goto) 2>nul & del "%~f0"
) else (
	echo Trình cài đặt đang ở phiên bản mới nhất.
	timeout /t 3 > nul
)

:dotnetRuntime_check
if exist "%programfiles%\dotnet\shared\Microsoft.WindowsDesktop.App\9.0.4" (
goto exe_check
) else (
cls
if not exist tools/redists/windowsdesktop-runtime-9.0.4-win-x64.exe (
	echo Đang tải .NET 9.0 Desktop Runtime bản 9.0.4...
	"tools/wget.exe" -c -q --show-progress --directory-prefix tools\redists https://builds.dotnet.microsoft.com/dotnet/WindowsDesktop/9.0.4/windowsdesktop-runtime-9.0.4-win-x64.exe || goto first_launch_download_failed
)
cls
echo Đang cài đặt .NET 9.0 Desktop Runtime bản 9.0.4...
echo Vui lòng chấp nhận yêu cầu của Windows.
"tools/redists/windowsdesktop-runtime-9.0.4-win-x64.exe" /install /quiet /norestart
if errorlevel 1 (
	MODE 70,10
	cls
	title LỖI!
	echo Bạn phải cài .NET 9.0 Desktop Runtime bản 9.0.4 để chạy mod.
	echo Hãy chạy lại trình cài đặt để cài .NET Desktop Runtime.
	echo Nhấn phím bất kỳ để thoát.
	pause>nul
	exit
) else (
	goto exe_check
	)
)

:exe_check
if exist P4G.exe (
cls
goto md5_check
cls
) else (
MODE 87,10
echo Không tìm được tệp tin thực thi của Persona 4 Golden (P4G.exe^). Vui lòng kiểm tra xem
echo tệp tin p4gvh.bat có được đặt cùng P4G.exe hay không.
echo Nhấn phím bất kỳ để thoát.
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
echo Nhấn phím bất kỳ để thoát.
pause > nul
exit
)
	
:ask_for_update
MODE 100,10
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
	echo Bạn có muốn kiểm tra cập nhật mod Việt hóa?
	choice /c YN /n /m "Nhấn Y để chấp nhận, hoặc nhấn N để từ chối."
	if !errorlevel! EQU 2 (
		goto main_steam
	)
	goto content_check
)

:first_launch
if not exist p4pcvh-core.zip (
	echo Đang tải mod Việt hóa (Core^)...
	"tools/wget.exe" -c -q --show-progress -O .\p4pcvh-core_part.zip https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/uwihw8ah4pVV-core.zip || goto first_launch_download_failed
	ren p4pcvh-core_part.zip p4pcvh-core.zip
	"tools/7z.exe" x p4pcvh-core.zip -aoa || goto extract_failed
	del p4pcvh-core.zip
) else (
	"tools/7z.exe" x p4pcvh-core.zip -aoa || goto extract_failed
	del p4pcvh-core.zip
)

REM if not exist p4pcvh-core-contentpack2.zip (
	REM echo Đang tải mod Việt hóa (Video phụ đề^)...
	REM "tools/wget.exe" -c -q --show-progress -O .\p4pcvh-core-contentpack2_part.zip https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/uwihw8ah4pVV-core-contentpack2.zip || goto first_launch_download_failed
	REM ren p4pcvh-core-contentpack2_part.zip p4pcvh-core-contentpack2.zip
	REM "tools/7z.exe" x p4pcvh-core-contentpack2.zip -aoa || goto extract_failed
	REM del p4pcvh-core-contentpack2.zip
REM ) else (
	REM "tools/7z.exe" x p4pcvh-core-contentpack2.zip -aoa || goto extract_failed
	REM del p4pcvh-core-contentpack2.zip
REM )

:content_check
chcp 437 > nul 2>&1
for /f "delims=" %%g in ('powershell "((Invoke-RestMethod https://api.github.com/repos/KoAiBitTuiLaAi/gnugnugbu/releases/latest -timeout 2).body.Split("\"`n"\") | Select-String -Pattern 'build tag:') -replace  'build tag: '"') do @set git_version=%%g
if exist reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll (
   for /f "delims=" %%v in ('powershell "((Get-Item reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll).VersionInfo.FileVersion) -replace '1.0.0.'"') do @set version=%%v
   chcp 65001 > nul 2>&1
)
set boot=0
chcp 65001 > nul 2>&1

if not exist p4pcvh-latest.zip (
    echo Kiểm tra cập nhật mod Việt hóa...
    if "%version%" EQU "%git_version%" (
	    echo Mod Việt hóa số %version% của bạn đang là phiên bản mới nhất.
		echo Nhấn phím bất kỳ để trở về trình cài đặt.
		pause>nul
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
		powershell "Invoke-WebRequest https://github.com/KoAiBitTuiLaAi/gnugnugbu/releases/download/dwawahjdawausuu/uwihw8ah4pVV-latest.zip -OutFile p4pcvh-latest.zip" || goto content_check_update_failed
		chcp 65001 > nul 2>&1
	)
) else (
	set boot=1
)

if exist p4pcvh-latest.zip (
	echo Đã tải xong, đang giải nén nội dung...
	"tools/7z.exe" x p4pcvh-latest.zip -aoa || goto extract_failed
	del p4pcvh-latest.zip
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
	echo Nhấn phím bất kỳ để thoát.
	pause > nul
	exit
)

:first_launch_download_failed
chcp 65001 > nul 2>&1
echo Đã có lỗi xảy ra trong khi tải về nội dung. Xin hãy chạy lại
echo trình cài đặt.
echo Nhấn phím bất kỳ để thoát.
pause>nul
exit

:update_check_download_failed
chcp 65001 > nul 2>&1
cls
echo Đã có lỗi xảy ra trong khi kiểm tra cập nhật trình cài đặt.
echo Xin hãy chạy lại trình cài đặt.
echo Nhấn phím bất kỳ để thoát.
pause>nul
exit

:content_check_update_failed
chcp 65001 > nul 2>&1
echo Đã có lỗi xảy ra trong quá trình tải về cập nhật.
echo Nhấn phím bất kỳ để thoát.
pause > nul
exit

:extract_failed
chcp 65001 > nul 2>&1
echo Đã có lỗi xảy ra trong quá trình giải nén.
echo Nhấn phím bất kỳ để thoát.
pause > nul
exit

:main_steam
MODE 120,30
chcp 437 > nul 2>&1
set /p batchLatestVer=<batchLatestVer.txt
set /p buildTag=<reloaded2\Mods\p4gpc.localize.k8.release\tag.txt
for /f "delims=" %%v in ('powershell "((Get-Item reloaded2\Mods\p4gpc.localize.k8.release\vidsubtitles_release.dll).VersionInfo.FileVersion) -replace '1.0.0.'"') do @set version=%%v
call batch\main.bat
echo Số phiên bản của trình cài đặt: %batchLatestVer%
echo Phiên bản mod: %version% (%buildTag%^)
echo Vui lòng chọn:
echo 1. Cài mod Việt hóa
echo 2. Gỡ mod Việt hóa
echo 3. Truy cập diễn đàn Việt Hóa Game
echo 4. Tham gia máy chủ Discord
echo 5. Thoát
set chon=
set /p chon=Nhập số: 
if not '%chon%'=='' set chon=%chon:~0,1%
if '%chon%'=='1' goto k8_prereq_steam
if '%chon%'=='2' goto k8_uninstall_steam
if '%chon%'=='3' goto forum
if '%chon%'=='4' goto discord
if '%chon%'=='5' exit
echo Bạn chưa chọn gì cả.
timeout /t 10
goto main_steam

:k8_prereq_steam
cls
title Trình cài đặt Persona 4 Golden Việt hóa - ĐANG CÀI
cls
if not exist %appdata%\k8_reloaded2-loader_rl\ReloadedII.json (
	echo Đang cài... Vui lòng đợi.
	call batch\run_pre.bat > nul
	call batch\run_apps.bat > nul
	title Trình cài đặt Persona 4 Golden Việt hóa - ĐÃ CÀI XONG
	cls
	echo Đã cài xong.
	echo Nhấn phím bất kỳ để quay về màn hình chính.
	pause>nul
	goto main_steam
) else (
	echo Bạn đã cài Việt hóa. Để cài lại, hãy gỡ cài đặt trước.
	echo Nhấn phím bất kỳ để quay về màn hình chính.
	pause>nul
	goto main_steam
)

:k8_uninstall_steam
title Trình cài đặt Persona 4 Golden Việt hóa - ĐANG GỠ CÀI ĐẶT > nul
cls
echo Đang gỡ... Vui lòng đợi.
call batch\uninstall.bat > nul
exit

:forum
start https://viethoagame.com/threads/764/
goto main_steam

:discord
start https://discord.com/invite/Cjqy2SCzYB/
goto main_steam
