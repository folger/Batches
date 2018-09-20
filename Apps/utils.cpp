#include <Origin.h>


int GetAppIDByName(string name)
{
	foreach (OrgAppInfo appInfo in OrgApps.InstalledApps)
	{
		if (appInfo.Name == name)
			return appInfo.ID;
	}
	return 0;
}
