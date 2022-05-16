#ifndef included
#error This script can only be compiled as a #include
#endif

#ifndef __ATTRIBS_M
#define __ATTRIBS_M

#include "gen_pageguids.m"


Function initAttribs_aart();

Global ConfigAttribute albumart_visible_attrib;


initAttribs_aart() {

	initPages();
	
	albumart_visible_attrib = custom_windows_page.newAttribute("Album Art\tAlt+A", "1");

}

#endif