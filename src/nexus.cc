/*
 * Copyright (c) 2010-2011 Stephen Williams (steve@icarus.com)
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

# include  "vcd_priv.h"
# include  <map>
# include  <set>
# include  <string>

/*
   Nexus Id cache

   In structural models, many signals refer to the same nexus.
   Some structural models also have very many signals.  This cache
   saves nexus_id - vcd_id pairs, and reuses the vcd_id when a signal
   refers to a nexus that is already dumped.

   The new signal will be listed as a $var, but no callback
   will be installed.  This saves considerable CPU time and leads
   to smaller VCD files.

   The _vpiNexusId is a private (int) property of IVL simulators.
*/

static std::map<int,const char*> nexus_ident_map;

extern "C" const char*find_nexus_ident(int nex)
{
      std::map<int,const char*>::const_iterator cur = nexus_ident_map.find(nex);
      if (cur == nexus_ident_map.end())
	    return 0;
      else
	    return cur->second;
}

extern "C" void set_nexus_ident(int nex, const char*id)
{
      nexus_ident_map[nex] = id;
}

extern "C" void nexus_ident_delete()
{
      nexus_ident_map.clear();
}


static std::set<std::string> vcd_scope_names_set;

extern "C" void vcd_scope_names_add(const char*name)
{
      vcd_scope_names_set .insert(name);
}

extern "C" int vcd_scope_names_test(const char*name)
{
      if (vcd_scope_names_set.find(name) == vcd_scope_names_set.end())
	    return 0;
      else
	    return 1;
}

extern "C" void vcd_scope_names_delete(void)
{
      vcd_scope_names_set.clear();
}
