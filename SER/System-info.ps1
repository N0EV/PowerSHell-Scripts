# Establecer la ruta del archivo de salida
$outputFile = "C:\InformacionDelSistema.txt"

# Obtener información del sistema
$computerName = $env:COMPUTERNAME
$os = Get-CimInstance Win32_OperatingSystem
$memory = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

# Crear contenido para el archivo
$content = @"
Información del Sistema
-------------------
Nombre del equipo: $computerName
Versión del sistema operativo: $($os.Caption) $($os.Version)
Memoria total (GB): [math]::round($memory.Sum / 1GB, 2)

Espacio en disco:
"@

foreach ($d in $disk) {
    $content += "Unidad: $($d.DeviceID) - Espacio libre (GB): [math]::round($d.FreeSpace / 1GB, 2) - Tamaño total (GB): [math]::round($d.Size / 1GB, 2)"
}

# Guardar la información en el archivo
$content | Out-File -FilePath $outputFile -Encoding utf8

# Mostrar un mensaje de éxito
Write-Host "La información del sistema ha sido guardada en $outputFile"
