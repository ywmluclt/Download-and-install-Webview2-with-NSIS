# Install webview2 by launching the bootstrapper
# See https://docs.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution#online-only-deployment
Function installWebView2

	# If this key exists and is not empty then webview2 is already installed
	# Clear error, then check existed 

	ClearErrors

	ReadRegStr $0 HKLM "SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" "pv"

	${If} ${Errors} 
	${OrIf} $0 == ""

		DetailPrint "Dowloading: WebView2 Runtime"
		
		InetLoad::load "http://go.microsoft.com/fwlink/p/?LinkId=2124703" "$TEMP\MicrosoftEdgeWebview2Setup.exe"
        Pop $R0

		StrCmp $R0 "OK" OK
			MessageBox MB_OK|MB_ICONEXCLAMATION "Failed to download WebView2 Runtime. ${PRODUCT_NAME} will continue to install, but the Map in ${PRODUCT_NAME} will not run properly without WebView2 Runtime. You must install WebView2 Runtime manually."
			Goto done_installWebView2_function
        OK:

		DetailPrint "Installing: WebView2 Runtime"
		ExecWait '"$TEMP\MicrosoftEdgeWebview2Setup.exe" /silent /install'

	${EndIf}

	#exit the function
	done_installWebView2_function:

FunctionEnd
