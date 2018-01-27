@ECHO OFF

echo.                
echo .---------------------------------------------------.
echo ^|                                                   ^|
echo ^|   Chameleon-Mini Rev-E Rebooted flasher utility   ^|
echo ^|                                                   ^|
echo `---------------------------------------------------'
echo.

if not exist "%~dp0BOOT_LOADER_EXE.exe" (
	echo Cannot find BOOT_LOADER_EXE.exe. Please run this .bat script in the same directory where BOOT_LOADER_EXE.exe is saved.
	pause > nul
	exit
)

if not exist "%~dp0avr-objcopy.exe" (
	echo Cannot find avr-objcopy.exe. Please run this .bat script in the same directory where avr-objcopy.exe is saved.
	pause > nul
	exit
)

if not exist "%~dp0Createbin.exe" (
	echo Cannot find Createbin.exe. Please run this .bat script in the same directory where Createbin.exe is saved.
	pause > nul
	exit
)

if not exist "%~dp0ITS_A_CARD.eep" (
	echo Cannot find ITS_A_CARD.eep. Please run this .bat script in the same directory where ITS_A_CARD.eep and ITS_A_CARD.hex are saved.
	pause > nul
	exit
)

if not exist "%~dp0ITS_A_CARD.hex" (
	echo Cannot find ITS_A_CARD.hex. Please run this .bat script in the same directory where ITS_A_CARD.eep and ITS_A_CARD.hex are saved.
	pause > nul
	exit
)

echo Creating the EEPROM binary...
"%~dp0avr-objcopy.exe" -I ihex "%~dp0ITS_A_CARD.eep" -O binary eeprom.bin

"%~dp0Createbin.exe" eeprom.bin bin

del eeprom.bin

echo.
echo.

move myfile.bin myfilee.bin >nul

echo Creating the Flash binary...
"%~dp0avr-objcopy.exe" -I ihex "%~dp0ITS_A_CARD.hex" -O binary flash.bin

"%~dp0Createbin.exe" flash.bin bin

del flash.bin

echo.
echo.

echo Flashing the files onto the "Chameleon-Mini Rev-E Rebooted"...
"%~dp0BOOT_LOADER_EXE.exe"

echo.

echo If there are no errors above, flashing the firmware to your "Chameleon-Mini Rev-E Rebooted" should be finished now. Enjoy!
