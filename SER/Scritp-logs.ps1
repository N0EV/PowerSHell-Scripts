<#Esto me imagino que lo que hace es decir quien lo envia#>
$from = "uncorreo@correo.com"
$smtpServer = "smtp.outlook.com"

<#Esto me imagino que lo que hace es decir a quien se lo envia#>
$to = "uncorreo@loqusea.es"
$subject = "Notificacion de $($env:computername)"
<#Esto no se lo que hace#>
$evento = Get-Eventing -LogName "Security" -Newest 1
<#
Esto tampoco se lo que hace 
Ademas no se ve bien lo que hay despues del igual de body
#>
$body = @"
Evento a revisar en $($evento.MachineName)
Identificador: $($evento.EventId)
Fuente: $($evento.Source)
Tipo: $($evento.EntryType)
Fecha / Hora: $($evento.TimeGenerated)
Texto: $($evento.Message)
"@
<#Esto tampoco se muy bien lo que hace#>
$smtpClient = New-Object System.Net.Mail.SmtpClient($smtpServer, 587)
$smtpClient.EnableSs1 = $true
$smtpClient.Credentials = New-Object System.Net.NetworkCredential("Usuario", "Contraseña")
$smtpClient.Send($from, $to, $subject, $body)
