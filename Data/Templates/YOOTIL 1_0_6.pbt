Assets {
  Id: 14902881683869157357
  Name: "YOOTIL 1.0.6"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 14927786042843232881
      Objects {
        Id: 14927786042843232881
        Name: "TemplateBundleDummy"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        Folder {
          BundleDummy {
            ReferencedAssets {
              Id: 16622261663679835299
            }
            ReferencedAssets {
              Id: 878888552064284504
            }
            ReferencedAssets {
              Id: 10898540908769460787
            }
            ReferencedAssets {
              Id: 10184849708620809770
            }
            ReferencedAssets {
              Id: 1028874171765522488
            }
            ReferencedAssets {
              Id: 1011343072688044724
            }
          }
        }
      }
    }
    Assets {
      Id: 1011343072688044724
      Name: "YOOTIL_Vector3"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nhttps://github.com/excessive/cpml/blob/master/modules/vec3.lua\r\n\r\nThe MIT License (MIT)\r\n\r\nCopyright (c) 2020 pixeldepth.net\r\n\r\nPermission is hereby granted, free of charge, to any person obtaining a copy\r\nof this software and associated documentation files (the \"Software\"), to deal\r\nin the Software without restriction, including without limitation the rights\r\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\r\ncopies of the Software, and to permit persons to whom the Software is\r\nfurnished to do so, subject to the following conditions:\r\n\r\nThe above copyright notice and this permission notice shall be included in all\r\ncopies or substantial portions of the Software.\r\n\r\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\r\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\r\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\r\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\r\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\r\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\r\nSOFTWARE.\r\n]]\r\n\r\nlocal _Vector3 = {}\r\n\r\n_Vector3.distance = function(a, b)\r\n\tlocal dx = a.x - b.x\r\n\tlocal dy = a.y - b.y\r\n\tlocal dz = a.z - b.z\r\n\r\n\treturn math.sqrt(dx * dx + dy * dy + dz * dz)\r\nend\r\n\r\n_Vector3.distance_squared = function(a, b)\r\n\tlocal dx = a.x - b.x\r\n\tlocal dy = a.y - b.y\r\n\tlocal dz = a.z - b.z\r\n\r\n\treturn dx * dx + dy * dy + dz * dz\r\nend\r\n\r\n_Vector3.scale = function(a, b)\r\n\treturn Vector3.New(a.x * b, a.y * b, a.z * b)\r\nend\r\n\r\n_Vector3.is_zero = function(a)\r\n\treturn a.x == 0 and a.y == 0 and a.z == 0\r\nend\r\n\r\n_Vector3.cross = function(a, b)\r\n\treturn Vector3.New(\r\n\t\ta.y * b.z - a.z * b.y,\r\n\t\ta.z * b.x - a.x * b.z,\r\n\t\ta.x * b.y - a.y * b.x\r\n\t)\r\nend\r\n\r\n_Vector3.dot = function(a, b)\r\n\treturn a.x * b.x + a.y * b.y + a.z * b.z\r\nend\r\n\r\n_Vector3.len = function(a)\r\n\treturn math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)\r\nend\r\n\r\n_Vector3.normalize = function(a)\r\n\tif(Vector3.is_zero(a)) then\r\n\t\treturn Vector3.New()\r\n\tend\r\n\r\n\treturn Vector3.scale(a, 1 / Vector3.len(a))\r\nend\r\n\r\nreturn _Vector3"
      }
      Marketplace {
        Description: "An API for tweening and some utils.\r\n\r\n1.0.5\r\n   - String truncation\r\n\r\n1.0.4\r\n   - Alias :play for :continue\r\n\r\n1.0.3\r\n   - Added method \"concat_table\" to Utils\r\n\r\n1.0.2\r\n   - Added pause method\r\n   - Added continue method\r\n   - Chaining added to :reset()\r\n\r\n1.0.1\r\n   - Fixed a bug with start event being set to nil, so :reset would not reset the start event correctly.\r\n   - Changed start to tween\r\n\r\n1.0.0 \r\n   - Added number_format\r\n"
      }
      DirectlyPublished: true
    }
    Assets {
      Id: 1028874171765522488
      Name: "YOOTIL_Vector2"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nhttps://github.com/excessive/cpml/blob/master/modules/vec2.lua\r\n\r\nThe MIT License (MIT)\r\n\r\nCopyright (c) 2020 pixeldepth.net\r\n\r\nPermission is hereby granted, free of charge, to any person obtaining a copy\r\nof this software and associated documentation files (the \"Software\"), to deal\r\nin the Software without restriction, including without limitation the rights\r\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\r\ncopies of the Software, and to permit persons to whom the Software is\r\nfurnished to do so, subject to the following conditions:\r\n\r\nThe above copyright notice and this permission notice shall be included in all\r\ncopies or substantial portions of the Software.\r\n\r\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\r\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\r\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\r\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\r\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\r\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\r\nSOFTWARE.\r\n]]\r\n\r\nlocal _Vector2 = {}\r\n\r\n_Vector2.distance = function(a, b)\r\n\tlocal dx = a.x - b.x\r\n\tlocal dy = a.y - b.y\r\n\r\n\treturn math.sqrt(dx * dx + dy * dy)\r\nend\r\n\r\n_Vector2.distance_squared = function(a, b)\r\n\tlocal dx = a.x - b.x\r\n\tlocal dy = a.y - b.y\r\n\r\n\treturn dx * dx + dy * dy\r\nend\r\n\r\n_Vector2.scale = function(a, b)\r\n\treturn Vector2.New(a.x * b, a.y * b)\r\nend\r\n\r\n_Vector2.is_zero = function(a)\r\n\treturn a.x == 0 and a.y == 0\r\nend\r\n\r\n_Vector2.cross = function(a, b)\r\n\treturn a.x * b.y - a.y * b.x\r\nend\r\n\r\n_Vector2.dot = function(a, b)\r\n\treturn a.x * b.x + a.y * b.y\r\nend\r\n\r\n_Vector2.len = function(a)\r\n\treturn math.sqrt(a.x * a.x + a.y * a.y)\r\nend\r\n\r\n_Vector2.normalize = function(a)\r\n\tif(Vector2.is_zero(a)) then\r\n\t\treturn Vector2.New()\r\n\tend\r\n\r\n\treturn Vector2.scale(a, 1 / Vector2.len(a))\r\nend\r\n\r\n_Vector2.angle_to = function(a, b)\r\n\tif(b) then\r\n\t\treturn math.deg(math.atan(a.y - b.y, a.x - b.x))\r\n\tend\r\n\r\n\treturn math.deg(math.atan(a.y, a.x))\r\nend\r\n\r\nreturn _Vector2"
      }
    }
    Assets {
      Id: 10184849708620809770
      Name: "YOOTIL_Utils"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nThe MIT License (MIT)\r\n\r\nCopyright (c) 2020 pixeldepth.net\r\n\r\nPermission is hereby granted, free of charge, to any person obtaining a copy\r\nof this software and associated documentation files (the \"Software\"), to deal\r\nin the Software without restriction, including without limitation the rights\r\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\r\ncopies of the Software, and to permit persons to whom the Software is\r\nfurnished to do so, subject to the following conditions:\r\n\r\nThe above copyright notice and this permission notice shall be included in all\r\ncopies or substantial portions of the Software.\r\n\r\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\r\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\r\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\r\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\r\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\r\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\r\nSOFTWARE.\r\n]]\r\n\r\nlocal Utils = {}\r\n\r\nfunction Utils.dump(o)\r\n\tif(type(o) == \"table\") then\r\n\t   local s = \"{ \"\r\n\r\n\t\tfor k,v in pairs(o) do\r\n\t\t\tif(type(k) ~= \"number\") then \r\n\t\t\t\tk = \"\\\"\"..k..\"\\\"\"\r\n\t\t\tend\r\n\r\n\t\t\ts = s .. \"[\"..k..\"] = \" .. Utils.dump(v) .. \",\"\r\n\t\tend\r\n\r\n\t\treturn s .. \"} \"\r\n\telse\r\n\t\treturn tostring(o)\r\n\tend\r\n end\r\n\r\n function Utils.dumpp(o)\r\n\treturn print(Utils.dump(o))\r\n end\r\n\r\n Utils.Queue = {}\r\n\r\nfunction Utils.Queue.push(self, item)\r\n\ttable.insert(self.list, item)\r\nend\r\n\r\nfunction Utils.Queue.pop(self)\r\n\treturn table.remove(self.list, 1)\r\nend\r\n\r\nfunction Utils.Queue.is_empty(self)\r\n\treturn #self.list == 0\r\nend\r\n\r\nfunction Utils.Queue.length(self)\r\n\treturn #self.list\r\nend\r\n\r\nfunction Utils.Queue.new()\r\n\treturn setmetatable({list = {}}, {__index = Utils.Queue})\r\nend\r\n\r\nfunction Utils.number_format(i)\r\n\treturn tostring(i):reverse():gsub(\"%d%d%d\", \"%1,\"):reverse():gsub(\"^,\", \"\")\r\nend\r\n\r\nfunction Utils.concat_table(t1, t2)\r\n    for i = 1, #t2 do\r\n        t1[#t1 + i] = t2[i]\r\n\tend\r\n\t\r\n    return t1\r\nend\r\n\r\nfunction Utils.truncate(str, len, post_str)\r\n\tlocal the_str = str\r\n\tlocal p_str = post_str or \"\"\r\n\r\n\tif(#str > len) then\r\n\t\tthe_str = the_str:sub(1, len) .. p_str\r\n\tend\r\n\r\n\treturn the_str\r\nend\r\n\r\nfunction Utils.uuid()\r\n\tmath.randomseed(os.time())\r\n\r\n\tlocal template = \"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx\"\r\n    \r\n\treturn string.gsub(template, \"[xy]\", function(c)\r\n\t\tlocal v = (c == \"x\") and math.random(0, 0xf) or math.random(8, 0xb)\r\n        \r\n\t\treturn string.format(\"%x\", v)\r\n\tend)\r\nend\r\n\r\nreturn Utils"
      }
      Marketplace {
        Description: "An API for tweening and some utils.\r\n\r\n1.0.5\r\n   - String truncation\r\n\r\n1.0.4\r\n   - Alias :play for :continue\r\n\r\n1.0.3\r\n   - Added method \"concat_table\" to Utils\r\n\r\n1.0.2\r\n   - Added pause method\r\n   - Added continue method\r\n   - Chaining added to :reset()\r\n\r\n1.0.1\r\n   - Fixed a bug with start event being set to nil, so :reset would not reset the start event correctly.\r\n   - Changed start to tween\r\n\r\n1.0.0 \r\n   - Added number_format\r\n"
      }
      DirectlyPublished: true
    }
    Assets {
      Id: 10898540908769460787
      Name: "YOOTIL_Tween_Easings"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nDisclaimer for Robert Penner\'s Easing Equations license:\r\n\r\nTERMS OF USE - EASING EQUATIONS\r\n\r\nOpen source under the BSD License.\r\n\r\nCopyright \302\251 2001 Robert Penner\r\nAll rights reserved.\r\n\r\nRedistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:\r\n\r\n    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.\r\n    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.\r\n    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.\r\n\r\nTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\r\n]]\r\n\r\n-- For all easing functions:\r\n-- t = elapsed time\r\n-- b = begin\r\n-- c = change == ending - beginning\r\n-- d = duration (total time)\r\n\r\nlocal pow = function(a, b)\r\n    return a ^ b\r\nend\r\n\r\nlocal sin = math.sin\r\nlocal cos = math.cos\r\nlocal pi = math.pi\r\nlocal sqrt = math.sqrt\r\nlocal abs = math.abs\r\nlocal asin  = math.asin\r\n\r\nlocal function linear(t, b, c, d)\r\n  return c * t / d + b\r\nend\r\n\r\nlocal function inQuad(t, b, c, d)\r\n  t = t / d\r\n  return c * pow(t, 2) + b\r\nend\r\n\r\nlocal function outQuad(t, b, c, d)\r\n  t = t / d\r\n  return -c * t * (t - 2) + b\r\nend\r\n\r\nlocal function inOutQuad(t, b, c, d)\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * pow(t, 2) + b\r\n  else\r\n    return -c / 2 * ((t - 1) * (t - 3) - 1) + b\r\n  end\r\nend\r\n\r\nlocal function outInQuad(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outQuad (t * 2, b, c / 2, d)\r\n  else\r\n    return inQuad((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inCubic (t, b, c, d)\r\n  t = t / d\r\n  return c * pow(t, 3) + b\r\nend\r\n\r\nlocal function outCubic(t, b, c, d)\r\n  t = t / d - 1\r\n  return c * (pow(t, 3) + 1) + b\r\nend\r\n\r\nlocal function inOutCubic(t, b, c, d)\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * t * t * t + b\r\n  else\r\n    t = t - 2\r\n    return c / 2 * (t * t * t + 2) + b\r\n  end\r\nend\r\n\r\nlocal function outInCubic(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outCubic(t * 2, b, c / 2, d)\r\n  else\r\n    return inCubic((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inQuart(t, b, c, d)\r\n  t = t / d\r\n  return c * pow(t, 4) + b\r\nend\r\n\r\nlocal function outQuart(t, b, c, d)\r\n  t = t / d - 1\r\n  return -c * (pow(t, 4) - 1) + b\r\nend\r\n\r\nlocal function inOutQuart(t, b, c, d)\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * pow(t, 4) + b\r\n  else\r\n    t = t - 2\r\n    return -c / 2 * (pow(t, 4) - 2) + b\r\n  end\r\nend\r\n\r\nlocal function outInQuart(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outQuart(t * 2, b, c / 2, d)\r\n  else\r\n    return inQuart((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inQuint(t, b, c, d)\r\n  t = t / d\r\n  return c * pow(t, 5) + b\r\nend\r\n\r\nlocal function outQuint(t, b, c, d)\r\n  t = t / d - 1\r\n  return c * (pow(t, 5) + 1) + b\r\nend\r\n\r\nlocal function inOutQuint(t, b, c, d)\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * pow(t, 5) + b\r\n  else\r\n    t = t - 2\r\n    return c / 2 * (pow(t, 5) + 2) + b\r\n  end\r\nend\r\n\r\nlocal function outInQuint(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outQuint(t * 2, b, c / 2, d)\r\n  else\r\n    return inQuint((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inSine(t, b, c, d)\r\n  return -c * cos(t / d * (pi / 2)) + c + b\r\nend\r\n\r\nlocal function outSine(t, b, c, d)\r\n  return c * sin(t / d * (pi / 2)) + b\r\nend\r\n\r\nlocal function inOutSine(t, b, c, d)\r\n  return -c / 2 * (cos(pi * t / d) - 1) + b\r\nend\r\n\r\nlocal function outInSine(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outSine(t * 2, b, c / 2, d)\r\n  else\r\n    return inSine((t * 2) -d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inExpo(t, b, c, d)\r\n  if t == 0 then\r\n    return b\r\n  else\r\n    return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001\r\n  end\r\nend\r\n\r\nlocal function outExpo(t, b, c, d)\r\n  if t == d then\r\n    return b + c\r\n  else\r\n    return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b\r\n  end\r\nend\r\n\r\nlocal function inOutExpo(t, b, c, d)\r\n  if t == 0 then return b end\r\n  if t == d then return b + c end\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005\r\n  else\r\n    t = t - 1\r\n    return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b\r\n  end\r\nend\r\n\r\nlocal function outInExpo(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outExpo(t * 2, b, c / 2, d)\r\n  else\r\n    return inExpo((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inCirc(t, b, c, d)\r\n  t = t / d\r\n  return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)\r\nend\r\n\r\nlocal function outCirc(t, b, c, d)\r\n  t = t / d - 1\r\n  return(c * sqrt(1 - pow(t, 2)) + b)\r\nend\r\n\r\nlocal function inOutCirc(t, b, c, d)\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return -c / 2 * (sqrt(1 - t * t) - 1) + b\r\n  else\r\n    t = t - 2\r\n    return c / 2 * (sqrt(1 - t * t) + 1) + b\r\n  end\r\nend\r\n\r\nlocal function outInCirc(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outCirc(t * 2, b, c / 2, d)\r\n  else\r\n    return inCirc((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nlocal function inElastic(t, b, c, d, a, p)\r\n  if t == 0 then return b end\r\n\r\n  t = t / d\r\n\r\n  if t == 1  then return b + c end\r\n\r\n  if not p then p = d * 0.3 end\r\n\r\n  local s\r\n\r\n  if not a or a < abs(c) then\r\n    a = c\r\n    s = p / 4\r\n  else\r\n    s = p / (2 * pi) * asin(c/a)\r\n  end\r\n\r\n  t = t - 1\r\n\r\n  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b\r\nend\r\n\r\n-- a: amplitud\r\n-- p: period\r\nlocal function outElastic(t, b, c, d, a, p)\r\n  if t == 0 then return b end\r\n\r\n  t = t / d\r\n\r\n  if t == 1 then return b + c end\r\n\r\n  if not p then p = d * 0.3 end\r\n\r\n  local s\r\n\r\n  if not a or a < abs(c) then\r\n    a = c\r\n    s = p / 4\r\n  else\r\n    s = p / (2 * pi) * asin(c/a)\r\n  end\r\n\r\n  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b\r\nend\r\n\r\n-- p = period\r\n-- a = amplitud\r\nlocal function inOutElastic(t, b, c, d, a, p)\r\n  if t == 0 then return b end\r\n\r\n  t = t / d * 2\r\n\r\n  if t == 2 then return b + c end\r\n\r\n  if not p then p = d * (0.3 * 1.5) end\r\n  if not a then a = 0 end\r\n\r\n  local s\r\n\r\n  if not a or a < abs(c) then\r\n    a = c\r\n    s = p / 4\r\n  else\r\n    s = p / (2 * pi) * asin(c / a)\r\n  end\r\n\r\n  if t < 1 then\r\n    t = t - 1\r\n    return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b\r\n  else\r\n    t = t - 1\r\n    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b\r\n  end\r\nend\r\n\r\n-- a: amplitud\r\n-- p: period\r\nlocal function outInElastic(t, b, c, d, a, p)\r\n  if t < d / 2 then\r\n    return outElastic(t * 2, b, c / 2, d, a, p)\r\n  else\r\n    return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)\r\n  end\r\nend\r\n\r\nlocal function inBack(t, b, c, d, s)\r\n  if not s then s = 1.70158 end\r\n  t = t / d\r\n  return c * t * t * ((s + 1) * t - s) + b\r\nend\r\n\r\nlocal function outBack(t, b, c, d, s)\r\n  if not s then s = 1.70158 end\r\n  t = t / d - 1\r\n  return c * (t * t * ((s + 1) * t + s) + 1) + b\r\nend\r\n\r\nlocal function inOutBack(t, b, c, d, s)\r\n  if not s then s = 1.70158 end\r\n  s = s * 1.525\r\n  t = t / d * 2\r\n  if t < 1 then\r\n    return c / 2 * (t * t * ((s + 1) * t - s)) + b\r\n  else\r\n    t = t - 2\r\n    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b\r\n  end\r\nend\r\n\r\nlocal function outInBack(t, b, c, d, s)\r\n  if t < d / 2 then\r\n    return outBack(t * 2, b, c / 2, d, s)\r\n  else\r\n    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)\r\n  end\r\nend\r\n\r\nlocal function outBounce(t, b, c, d)\r\n  t = t / d\r\n  if t < 1 / 2.75 then\r\n    return c * (7.5625 * t * t) + b\r\n  elseif t < 2 / 2.75 then\r\n    t = t - (1.5 / 2.75)\r\n    return c * (7.5625 * t * t + 0.75) + b\r\n  elseif t < 2.5 / 2.75 then\r\n    t = t - (2.25 / 2.75)\r\n    return c * (7.5625 * t * t + 0.9375) + b\r\n  else\r\n    t = t - (2.625 / 2.75)\r\n    return c * (7.5625 * t * t + 0.984375) + b\r\n  end\r\nend\r\n\r\nlocal function inBounce(t, b, c, d)\r\n  return c - outBounce(d - t, 0, c, d) + b\r\nend\r\n\r\nlocal function inOutBounce(t, b, c, d)\r\n  if t < d / 2 then\r\n    return inBounce(t * 2, 0, c, d) * 0.5 + b\r\n  else\r\n    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b\r\n  end\r\nend\r\n\r\nlocal function outInBounce(t, b, c, d)\r\n  if t < d / 2 then\r\n    return outBounce(t * 2, b, c / 2, d)\r\n  else\r\n    return inBounce((t * 2) - d, b + c / 2, c / 2, d)\r\n  end\r\nend\r\n\r\nreturn {\r\n  linear = linear,\r\n  inQuad = inQuad,\r\n  outQuad = outQuad,\r\n  inOutQuad = inOutQuad,\r\n  outInQuad = outInQuad,\r\n  inCubic  = inCubic ,\r\n  outCubic = outCubic,\r\n  inOutCubic = inOutCubic,\r\n  outInCubic = outInCubic,\r\n  inQuart = inQuart,\r\n  outQuart = outQuart,\r\n  inOutQuart = inOutQuart,\r\n  outInQuart = outInQuart,\r\n  inQuint = inQuint,\r\n  outQuint = outQuint,\r\n  inOutQuint = inOutQuint,\r\n  outInQuint = outInQuint,\r\n  inSine = inSine,\r\n  outSine = outSine,\r\n  inOutSine = inOutSine,\r\n  outInSine = outInSine,\r\n  inExpo = inExpo,\r\n  outExpo = outExpo,\r\n  inOutExpo = inOutExpo,\r\n  outInExpo = outInExpo,\r\n  inCirc = inCirc,\r\n  outCirc = outCirc,\r\n  inOutCirc = inOutCirc,\r\n  outInCirc = outInCirc,\r\n  inElastic = inElastic,\r\n  outElastic = outElastic,\r\n  inOutElastic = inOutElastic,\r\n  outInElastic = outInElastic,\r\n  inBack = inBack,\r\n  outBack = outBack,\r\n  inOutBack = inOutBack,\r\n  outInBack = outInBack,\r\n  inBounce = inBounce,\r\n  outBounce = outBounce,\r\n  inOutBounce = inOutBounce,\r\n  outInBounce = outInBounce,\r\n}\r\n"
      }
      Marketplace {
        Description: "An API for tweening and some utils.\r\n\r\n1.0.5\r\n   - String truncation\r\n\r\n1.0.4\r\n   - Alias :play for :continue\r\n\r\n1.0.3\r\n   - Added method \"concat_table\" to Utils\r\n\r\n1.0.2\r\n   - Added pause method\r\n   - Added continue method\r\n   - Chaining added to :reset()\r\n\r\n1.0.1\r\n   - Fixed a bug with start event being set to nil, so :reset would not reset the start event correctly.\r\n   - Changed start to tween\r\n\r\n1.0.0 \r\n   - Added number_format\r\n"
      }
      DirectlyPublished: true
    }
    Assets {
      Id: 878888552064284504
      Name: "YOOTIL_Tween"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nThe MIT License (MIT)\r\n\r\nCopyright (c) 2020 pixeldepth.net\r\n\r\nPermission is hereby granted, free of charge, to any person obtaining a copy\r\nof this software and associated documentation files (the \"Software\"), to deal\r\nin the Software without restriction, including without limitation the rights\r\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\r\ncopies of the Software, and to permit persons to whom the Software is\r\nfurnished to do so, subject to the following conditions:\r\n\r\nThe above copyright notice and this permission notice shall be included in all\r\ncopies or substantial portions of the Software.\r\n\r\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\r\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\r\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\r\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\r\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\r\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\r\nSOFTWARE.\r\n]]\r\n\r\n--[[\r\nExample of how to use this library\r\n\r\nlocal my_tween = YOOTIL.Tween:new(.3, {a = 0}, {a = 1})\r\n\r\nmy_tween:on_complete(function()\r\n\tmy_tween = nil\r\nend)\r\n\t\r\nmy_tween:on_change(function(changed)\r\n\tlocal col = current_item:GetColor()\r\n\r\n\tcol.a = changed.a\r\n\tobj:SetColor(col)\r\nend)\r\n\r\nmy_tween:set_easing(\"outExpo\")\r\nmy_tween:delay(.5)\r\n\r\nfunction Tick()\r\n\tif(my_tween ~= nil and my_tween:active()) then\r\n\t\tmy_tween:tween(dt)\r\n\tend\r\nend\r\n]]\r\n\r\nlocal Tween = {}\r\n\r\nTween.Easings = require(script:GetCustomProperty(\"YOOTIL_Tween_Easings\"))\r\n\r\nTween.ease = function(from, to, original, time, duration, ease)\r\n\tfor k, v in pairs(to) do\r\n\t\tlocal t = time\r\n\t\tlocal b = original[k]\r\n\t\tlocal c = v - original[k]\r\n\t\tlocal d = duration\r\n\r\n\t\tfrom[k] = Tween.Easings[ease](t, b, c, d)\r\n\tend\r\n\r\n\treturn from\r\nend\r\n\r\nTween.copy_table = function(t)\r\n\tlocal tmp = {}\r\n\r\n\tfor k, v in pairs(t) do\r\n\t\ttmp[k] = v\r\n\tend\r\n\r\n\treturn tmp\r\nend\r\n\r\nfunction Tween:tween(delta)\r\n\tif(self.tween_finished or self.tween_paused) then\r\n\t\treturn\r\n\tend\r\n\r\n\tself.time = self.time + delta\r\n\r\n\tif(self.time < self.delay_tween) then\r\n\t\treturn\r\n\tend\r\n\r\n\tself.original = self.original or Tween.copy_table(self.from)\r\n\t\r\n\tif((self.time - self.delay_tween) >= self.duration) then\r\n\t\tself.from = Tween.copy_table(self.to)\r\n\r\n\t\tif(type(self.change_evt) == \"function\") then\r\n\t\t\tself.change_evt(self.to)\r\n\t\tend\r\n\t\t\r\n\t\tself.tween_finished = true\r\n\t\t\r\n\t\tif(type(self.complete_evt) == \"function\") then\r\n\t\t\tself.complete_evt()\r\n\t\tend\r\n\telse\r\n\t\tif(self.start_evt and not self.start_evt_invoked) then\r\n\t\t\tself.start_evt()\r\n\t\t\tself.start_evt_invoked = true\r\n\t\tend\r\n\r\n\t\tself.from = Tween.ease(self.from, self.to, self.original, self.time - self.delay_tween, self.duration, self.easing or \"linear\")\r\n\r\n\t\tif(type(self.change_evt) == \"function\") then\r\n\t\t\tself.change_evt(self.from)\r\n\t\tend\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:on_change(fn)\r\n\tif(fn and type(fn) == \"function\" and self.change_evt == nil) then\r\n\t\tself.change_evt = fn\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:set_from(from)\r\n\tself.original = from\r\nend\r\n\r\nfunction Tween:reset()\r\n\tself.time = 0\r\n\r\n\tself.from = Tween.copy_table(self.original_from)\r\n\tself.to = Tween.copy_table(self.original_to)\r\n\r\n\tself.start_evt_invoked = false\r\n\tself.original = nil\r\n\tself.tween_finished = false\r\n\tself.tween_paused = false\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:set_easing(ease)\r\n\tif(self.easing == nil and ease and Tween.Easings[ease]) then\r\n\t\tself.easing = ease\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:on_complete(fn)\r\n\tif(fn and type(fn) == \"function\" and self.complete_evt == nil) then\r\n\t\tself.complete_evt = fn\r\n\tend\r\n\t\r\n\treturn self\r\nend\r\n\r\nfunction Tween:on_start(fn)\r\n\tif(fn and type(fn) == \"function\" and self.start_evt == nil) then\r\n\t\tself.start_evt = fn\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:set_delay(delay_time)\r\n\tif(delay_time and delay_time > 0) then\r\n\t\tself.delay_tween = delay_time\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:paused()\r\n\treturn self.tween_paused\r\nend\r\n\r\nfunction Tween:pause()\r\n\tself.tween_paused = true\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:continue()\r\n\tself.tween_paused = false\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:play()\r\n\tself.tween_paused = false\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:stop()\r\n\tself.tween_finished = true\r\n\tself.tween_paused = false\r\n\r\n\tif(self.complete_evt and type(self.complete_evt) == \"function\") then\r\n\t\tself.complete_evt()\r\n\tend\r\n\r\n\treturn self\r\nend\r\n\r\nfunction Tween:active()\r\n\treturn not self.tween_finished\r\nend\r\n\r\n function Tween:new(duration, from, to, easing)\r\n\tself.__index = self\r\n\t\r\n\treturn setmetatable({\r\n \r\n\t\t duration = duration,\r\n\t\t from = from,\r\n\t\t to = to,\r\n\t\t time = 0,\r\n\t\t tween_finished = false,\r\n\t\t complete_evt = nil,\r\n\t\t start_evt = nil,\r\n\t\t easing = easing or nil,\r\n\t\t delay_tween = 0,\r\n\t\t time_started = 0,\r\n\t\t original_from = Tween.copy_table(from),\r\n\t\t original_to = Tween.copy_table(to),\r\n\t\t change_evt = nil,\r\n\t\t start_evt_invoked = false,\r\n\t\t tween_paused = false\r\n \r\n\t }, self)\r\n end\r\n\r\n return Tween"
        CustomParameters {
          Overrides {
            Name: "cs:YOOTIL_Tween_Easings"
            AssetReference {
              Id: 10898540908769460787
            }
          }
        }
      }
      Marketplace {
        Description: "An API for tweening and some utils.\r\n\r\n1.0.5\r\n   - String truncation\r\n\r\n1.0.4\r\n   - Alias :play for :continue\r\n\r\n1.0.3\r\n   - Added method \"concat_table\" to Utils\r\n\r\n1.0.2\r\n   - Added pause method\r\n   - Added continue method\r\n   - Chaining added to :reset()\r\n\r\n1.0.1\r\n   - Fixed a bug with start event being set to nil, so :reset would not reset the start event correctly.\r\n   - Changed start to tween\r\n\r\n1.0.0 \r\n   - Added number_format\r\n"
      }
      DirectlyPublished: true
    }
    Assets {
      Id: 16622261663679835299
      Name: "YOOTIL"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\nThe MIT License (MIT)\r\n\r\nCopyright (c) 2020 pixeldepth.net\r\n\r\nPermission is hereby granted, free of charge, to any person obtaining a copy\r\nof this software and associated documentation files (the \"Software\"), to deal\r\nin the Software without restriction, including without limitation the rights\r\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\r\ncopies of the Software, and to permit persons to whom the Software is\r\nfurnished to do so, subject to the following conditions:\r\n\r\nThe above copyright notice and this permission notice shall be included in all\r\ncopies or substantial portions of the Software.\r\n\r\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\r\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\r\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\r\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\r\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\r\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\r\nSOFTWARE.\r\n]]\r\n\r\nlocal API = {}\r\n\r\nAPI.require = function(api)\r\n\treturn require(script:GetCustomProperty(\"YOOTIL_\" .. api))\r\nend\r\n\r\nAPI.Utils = API.require(\"Utils\")\r\nAPI.Tween = API.require(\"Tween\")\r\nAPI.Vector3 = API.require(\"Vector3\")\r\nAPI.Vector2 = API.require(\"Vector2\")\r\n\r\nreturn API"
        CustomParameters {
          Overrides {
            Name: "cs:YOOTIL_Utils"
            AssetReference {
              Id: 10184849708620809770
            }
          }
          Overrides {
            Name: "cs:YOOTIL_Tween"
            AssetReference {
              Id: 878888552064284504
            }
          }
          Overrides {
            Name: "cs:YOOTIL_Vector3"
            AssetReference {
              Id: 1011343072688044724
            }
          }
          Overrides {
            Name: "cs:YOOTIL_Vector2"
            AssetReference {
              Id: 1028874171765522488
            }
          }
        }
      }
      Marketplace {
        Description: "An API for tweening and some utils.\r\n\r\n1.0.5\r\n   - String truncation\r\n\r\n1.0.4\r\n   - Alias :play for :continue\r\n\r\n1.0.3\r\n   - Added method \"concat_table\" to Utils\r\n\r\n1.0.2\r\n   - Added pause method\r\n   - Added continue method\r\n   - Chaining added to :reset()\r\n\r\n1.0.1\r\n   - Fixed a bug with start event being set to nil, so :reset would not reset the start event correctly.\r\n   - Changed start to tween\r\n\r\n1.0.0 \r\n   - Added number_format\r\n"
      }
      DirectlyPublished: true
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Id: "d6805fd4ac2249a6afddcaa944a1b307"
    OwnerAccountId: "93d6eaf2514940a08c5481a4c03c1ee3"
    OwnerName: "CommanderFoo"
  }
  SerializationVersion: 74
}
IncludesAllDependencies: true
