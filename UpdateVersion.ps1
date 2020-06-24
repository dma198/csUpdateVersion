#
# Script change project versions in all found *.csproj files
#


$newVersion = "2.0.0.0"

get-childitem "." -recurse | where {$_.extension -eq ".csproj"} | % {
    $path = $_.FullName
    $pattern = 	"(<Version>)([0-9,.]*)"
    (Get-Content $path)	 | ForEach-Object{
	if($_ -match $pattern){
          $pattern2 = "[0-9,.]+"
          $res = $_ -match $pattern2
          If($res){
            $prjFile = Split-Path $path -leaf
            $newLine = $_  -replace $pattern2,$newVersion            
	    Write-Host ("{0} : {1} => {2}" -f ($prjFile, $matches[0], $newVersion))		
	    #[console]::WriteLine ("{0} : {1} => {2}" -f ($prjFile, $matches[0], $newVersion))			
            $newLine		
          }
        }else{
	  $_
	}
    } | Set-Content $path

}





