param([string]$Root = ".")

Get-ChildItem -Path $Root -Directory -Recurse -Filter "*.parts" | ForEach-Object {
    $TargetFile = $_.FullName.Substring(0, $_.FullName.Length - 6)

    $Writer = New-Object System.IO.StreamWriter($TargetFile, $false, [System.Text.Encoding]::UTF8)

    try {
        Get-ChildItem -Path $_.FullName -File |
            Sort-Object Name |
            ForEach-Object {
                Get-Content $_.FullName | ForEach-Object {
                    $Writer.WriteLine($_)
                }
            }
    }
    finally {
        $Writer.Dispose()
    }

    Write-Host "Rebuilt $TargetFile"
}
