function vaultOpen(fileName, assetType, tier) {
    console.log("Opening premium asset:", fileName, "| Type:", assetType, "| Tier:", tier);
    var assetPath = "./assets/" + encodeURIComponent(fileName);
    window.open(assetPath, '_blank');
}
