# Quien envia el correo
$from = "uncorreo@ejemplo.com"
$smtpServer = "smtp.tuproovedordecorreo.com"

# A quien envia el correo
$to = "uncorreo@loqusea.es"
$subject = "Notificacion de $($env:computername)"

# Recoge la información del ultimo log que se ha echo
$evento = Get-Eventlog -LogName "Security" -Newest 1

# Esto es lo que aparece en el correo que se envia recogiendo datos con las variables del sistema windows
$body = @"
Evento a revisar en $($evento.MachineName)
Identificador: $($evento.EventId)
Fuente: $($evento.Source)
Tipo: $($evento.EntryType)
Fecha / Hora: $($evento.TimeGenerated)
Texto: $($evento.Message)
"@

# Va a ir al smtp Server para autentificarse y enviar el correo
$smtpClient = New-Object System.Net.Mail.SmtpClient($smtpServer, 587)
$smtpClient.EnableSsl = $true
$smtpClient.Credentials = New-Object System.Net.NetworkCredential("Usuario(tuCorreo)", "Contraseña(La que generes para permitir que este script entre en el correo para enviarlo por ti)")
$smtpClient.Send($from, $to, $subject, $body)

# Esta ultima seccion tienes que poner tu correo y una contraseña que hayas generado para la aplicación en especifico
