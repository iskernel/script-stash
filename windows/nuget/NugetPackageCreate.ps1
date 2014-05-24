function CreateNugetPackage
{
	$projectName = $args[0]+".csproj"
	nuget spec
	nuget pack $projectName -IncludeReferencedProjects -Prop Configuration=Release
}

CreateNugetPackage $args[0]