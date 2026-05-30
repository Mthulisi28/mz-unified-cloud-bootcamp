function vaultOpen(fileName, assetType, tier) {
    console.log("Opening premium asset:", fileName, "| Type:", assetType, "| Tier:", tier);
    // Path resolution routing directly to the local static asset directory
    var assetPath = "./assets/" + encodeURIComponent(fileName);
    window.open(assetPath, '_blank');
}
