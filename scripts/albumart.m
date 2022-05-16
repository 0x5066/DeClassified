#include <lib/std.mi>
#include "attribs/init_albumart.m"

Global AlbumArtLayer waaa;
Global Layout aalayout;

System.onScriptLoaded()
{
	initAttribs_aart();
	Container albumart = System.getContainer("winamp.albumart");
	aalayout = albumart.getLayout("normal");
	waaa = getScriptGroup().findObject(getParam());
}

aalayout.onSetVisible (Boolean onoff)
{
	if (!onoff)
	{
		albumart_visible_attrib.setData("0");
	}
	else
	{
		albumart_visible_attrib.setData("1");
	}
}

albumart_visible_attrib.onDataChanged ()
{
	if (getData() == "1")
	{
		aalayout.show();
	}
	else
	{
		aalayout.hide();
	}
}

System.onKeyDown(String key)
{
	if (key == "alt+a")
	{
		if (albumart_visible_attrib.getData() == "0")
				albumart_visible_attrib.setData("1");
		else
				albumart_visible_attrib.setData("0");
		complete;
	}
}

waaa.onRightButtonDown (int x, int y)
{
	popupmenu p = new popupmenu;

	p.addCommand("Get Album Art", 1, 0, 0);
	p.addCommand("Refresh Album Art", 2, 0, 0);
	p.addCommand("Open Folder", 3, 0, 0);

	int result = p.popatmouse();
	delete p;

	if (result == 1)
	{
		if (system.getAlbumArt(system.getPlayItemString()) > 0)
		{
			waaa.refresh();
		}
	}
	else if (result == 2)
	{
		waaa.refresh();
	}
	else if (result == 3)
	{
		System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
	}
}

waaa.onLeftButtonDblClk (int x, int y)
{
	System.navigateUrl(getPath(getPlayItemMetaDataString("filename")));
}