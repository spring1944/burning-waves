function widget:GetInfo()
  return {
    name      = "Map edge extension",
    version   = "0.7r",
    desc      = "Draws a mirrored map next to the edges of the real map",
    author    = "Pako",
    date      = "2010.10.27 - 2011.12.01", --YYYY.MM.DD, created - updated
    license   = "GPL",
    layer     = 0,
    enabled   = false
  }
end

--TODO make a barrier or something to hide the vertex gaps at edge and to help distinguish the playing area

local useShader = true --when using shader the map is stored once in a DL and drawn 8 times with vertex mirroring and bending
                       --when not, the map is drawn mirrored 8 times into a display list
local wiremap = false
local gridSize = 128

local shaderTable = {
uniform = {
      mirrorX = 0,
      mirrorZ = 0,
      up = 0,
      left = 0,
    },
vertex = [[
      // Application to vertex shader
      uniform float mirrorX;
      uniform float mirrorZ;
      uniform float left;
      uniform float up;

      void main()
      {
      gl_TexCoord[0]= gl_TextureMatrix[0]*gl_MultiTexCoord0;
      gl_Vertex.x = abs(mirrorX-gl_Vertex.x);
      gl_Vertex.z = abs(mirrorZ-gl_Vertex.z);
      if(mirrorX)gl_Vertex.y -= pow(abs(gl_Vertex.x-left*mirrorX)/150, 2);
      if(mirrorZ)gl_Vertex.y -= pow(abs(gl_Vertex.z-up*mirrorZ)/150, 2);

      float ff = 20000;
      if((mirrorZ && mirrorX))
        ff=ff/(pow(abs(gl_Vertex.z-up*mirrorZ)/150, 2)+pow(abs(gl_Vertex.x-left*mirrorX)/150, 2)+2);
      else if(mirrorX)
        ff=ff/(pow(abs(gl_Vertex.x-left*mirrorX)/150, 2)+2);
      else if(mirrorZ)
        ff=ff/(pow(abs(gl_Vertex.z-up*mirrorZ)/150, 2)+2);

gl_Position  = gl_ModelViewProjectionMatrix*gl_Vertex;
gl_FogFragCoord = //gl_Position.z+ff;
 length((gl_ModelViewMatrix * gl_Vertex).xyz)+ff; //see how Spring shaders do the fog and copy from there to fix this
      gl_FrontColor = gl_Color;
	  }
    ]],
}


local function DrawMapVertices(useMirrorShader)

local floor = math.floor
local ceil = math.ceil
local abs = math.abs

  gl.Color(1,1,1,1)

local function doMap(dx,dz,sx,sz)

	local Scale = gridSize
	local sggh = Spring.GetGroundHeight
	local Vertex = gl.Vertex
	local glColor = gl.Color
  local TexCoord = gl.TexCoord
  local Normal = gl.Normal
  local GetGroundNormal = Spring.GetGroundNormal
  local mapSizeX, mapSizeZ = Game.mapSizeX, Game.mapSizeZ

  local sten = {0, floor(Game.mapSizeZ/Scale)*Scale, 0}--do every other strip reverse
  local xm0, xm1 = 0, 0
  local xv0, xv1 = 0,math.abs(dx)+sx
  local ind = 0
  local zv
  local h

if not useMirrorShader then
  gl.TexCoord(0, sten[2]/Game.mapSizeZ)
  Vertex(xv1, sggh(0,sten[2]),abs(dz+sten[2])+sz)--start and end with a double vertex
end

  for x=0,Game.mapSizeX-Scale,Scale do
    xv0, xv1 = xv1, abs(dx+x+Scale)+sx
		xm0, xm1 = xm1, xm1+Scale
    ind = (ind+1)%2
		for z=sten[ind+1], sten[ind+2], (1+(-ind*2))*Scale do
				zv = abs(dz+z)+sz
        TexCoord(xm0/mapSizeX, z/mapSizeZ)
       -- Normal(GetGroundNormal(xm0,z))
        h = sggh(xm0,z)
				Vertex(xv0,h,zv)
        TexCoord(xm1/mapSizeX, z/mapSizeZ)
        --Normal(GetGroundNormal(xm1,z))
        h = sggh(xm1,z)
				Vertex(xv1,h,zv)
		end
	end
if not useMirrorShader then
  Vertex(xv1,h,zv)
end
end

if useMirrorShader then
  doMap(0,0,0,0)
else
  doMap(-Game.mapSizeX,-Game.mapSizeZ,-Game.mapSizeX,-Game.mapSizeZ)
  doMap(0,-Game.mapSizeZ,0,-Game.mapSizeZ)
  doMap(-Game.mapSizeX,-Game.mapSizeZ,Game.mapSizeX,-Game.mapSizeZ)

  doMap(-Game.mapSizeX,0,-Game.mapSizeX,0)
  doMap(-Game.mapSizeX,0,Game.mapSizeX,0)

  doMap(-Game.mapSizeX,-Game.mapSizeZ,-Game.mapSizeX,Game.mapSizeZ)
  doMap(0,-Game.mapSizeZ,0,Game.mapSizeZ)
  doMap(-Game.mapSizeX,-Game.mapSizeZ,Game.mapSizeX,Game.mapSizeZ)
end

end

local function DrawOMap(useMirrorShader)
	gl.Blending(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA)
	gl.DepthTest(GL.LEQUAL)
	gl.Texture('$grass')
	gl.BeginEnd(GL.TRIANGLE_STRIP,DrawMapVertices, useMirrorShader)
	gl.DepthTest(false)
	gl.Color(1,1,1,1)
	gl.Blending(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA)
end


local dList
local mirrorShader

local umirrorX
local umirrorZ
local uup
local uleft

function widget:Initialize()

	if gl.CreateShader and useShader then
    mirrorShader = gl.CreateShader(shaderTable)
  end
if not mirrorShader then
  widget.DrawWorldPreUnit = function()
    gl.DepthMask(true)
    --gl.Texture('$grass')
    gl.CallList(dList)
    gl.DepthMask(false)
    gl.Texture(false)
  end
  else
    umirrorX = gl.GetUniformLocation(mirrorShader,"mirrorX")
    umirrorZ = gl.GetUniformLocation(mirrorShader,"mirrorZ")
    uup = gl.GetUniformLocation(mirrorShader,"up")
    uleft = gl.GetUniformLocation(mirrorShader,"left")
end
dList = gl.CreateList(DrawOMap, mirrorShader)
--Spring.SetDrawGround(false)
end

function widget:Shutdown()
--Spring.SetDrawGround(true)
  gl.DeleteList(dList)
  if mirrorShader then
    gl.DeleteShader(mirrorShader)
  end
end

function widget:DrawWorldPreUnit() --is overwritten when not using the shader
  local glTranslate = gl.Translate
  local glUniform = gl.Uniform
  local GamemapSizeZ, GamemapSizeX = Game.mapSizeZ,Game.mapSizeX

gl.Fog(true)
--gl.FogCoord(1)
  gl.UseShader(mirrorShader)
  gl.PushMatrix()
  gl.DepthMask(true)
  --gl.Texture('$grass')
  if wiremap then
    gl.PolygonMode(GL.FRONT_AND_BACK, GL.LINE)
  end
  glUniform(umirrorX, GamemapSizeX)
  glUniform(umirrorZ, GamemapSizeZ)
  glUniform(uleft, 1)
  glUniform(uup, 1)
glTranslate(-GamemapSizeX,0,-GamemapSizeZ)
  gl.CallList(dList)
  glUniform(uleft , 0)
  glTranslate(GamemapSizeX*2,0,0)
  gl.CallList(dList)
  glUniform(uup, 0)
  glTranslate(0,0,GamemapSizeZ*2)
  gl.CallList(dList)
  glUniform(uleft, 1)
  glTranslate(-GamemapSizeX*2,0,0)
  gl.CallList(dList)

  glUniform(umirrorX, 0)
  glTranslate(GamemapSizeX,0,0)
  gl.CallList(dList)
  glUniform(uleft, 0)
  glUniform(uup, 1)
  glTranslate(0,0,-GamemapSizeZ*2)
  gl.CallList(dList)

  glUniform(uup, 0)
  glUniform(umirrorZ, 0)
  glUniform(umirrorX, GamemapSizeX)
  glTranslate(GamemapSizeX,0,GamemapSizeZ)
  gl.CallList(dList)
  glUniform(uleft, 1)
  glTranslate(-GamemapSizeX*2,0,0)
  gl.CallList(dList)

  if wiremap then
    gl.PolygonMode(GL.FRONT_AND_BACK, GL.FILL)
  end
  gl.DepthMask(false)
  gl.Texture(false)
  gl.PopMatrix()
  gl.UseShader(0)

  gl.Fog(false)
  
end
