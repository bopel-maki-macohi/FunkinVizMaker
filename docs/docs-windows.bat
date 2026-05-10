@ECHO OFF
cd /d "%~dp0.."
echo Generating documentation...
echo Platform is based on Windows
haxelib run lime build windows -D GENERATE_DOCS

echo The XML file for the API documentation has been generated at docs/doc.xml.

echo Autorunning html gen file
docs/html.bat