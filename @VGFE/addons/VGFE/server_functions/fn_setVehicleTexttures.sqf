

params["_vehicle","_textures"];
{
	_vehicle setObjectTextureGlobal [ _forEachIndex, format["%1",_textures select _forEachIndex] ];
}forEach _textures;