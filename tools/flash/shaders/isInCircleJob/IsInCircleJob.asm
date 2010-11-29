	version		1
	name		"IsInCircleJob"
	kernel		"namespace", "fr.digitas.flowearth.shaders::IsInCircleJob"
	kernel		"vendor", "Pierre Lepers"
	kernel		"version", 1
	kernel		"description", "your description"

	parameter	"_OutCoord", float2, f0.rg, in

	parameter	"center", float2, f0.ba, in
	meta		"defaultValue", 0, 0
	meta		"description", "[x,y] center position of the circle"

	parameter	"radius", float, f1.r, in
	meta		"defaultValue", 0
	meta		"description", "radius of the circle"

	texture		"src", t0.rg

	parameter	"dst", float, f2.r, out

;----------------------------------------------------------

	texb	f3, f0.rg, t0
	sub		f3.rg, f0.ba
	mov		f1.g, f3.r
	atan2	f1.g, f3.g
	mov		f1.b, f1.g
	len		f1.g, f3.rg
	mov		f1.a, f1.g
	mov		f2.g, f1.b
	ltn		f1.a, f1.r
	mov		i1.r, i0.r
	set		f1.g, 1
	set		f3.b, 0
	sel		f2.r, i1.r, f1.g, f3.b
