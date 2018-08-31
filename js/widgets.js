publishedVersions = widgetsData.versions.filter(function(version){
	return version.published === true;
});
latestVersion = widgetsData.versions.filter(function(version){
	return version.published === true && version.latest === true ;
});
currentVersionData = widgetsData.versions.filter(function(version){
	return version.title == version;
});

$(function(){
	$("#templates").load("/js/templates.html"); 
});
