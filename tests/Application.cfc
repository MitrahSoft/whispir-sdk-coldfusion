component{
	this.name = 'Whispir SDK ColdFusion Tests';

	this.mappings['/tests'] = getDirectoryFromPath(getCurrentTemplatePath());
	this.mappings['/testbox'] = getDirectoryFromPath(getCurrentTemplatePath()) & "../../testbox";
	this.mappings['/whispirColdFusionSDK'] = getDirectoryFromPath(getCurrentTemplatePath()) & "../com";

	
}
