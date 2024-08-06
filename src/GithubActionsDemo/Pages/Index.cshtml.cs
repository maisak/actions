using GithubActionsDemo.Options;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Options;

namespace GithubActionsDemo.Pages;

public class IndexModel(IOptions<AppSettings> settings) : PageModel
{
	public string Version { get; private set; } = "0.0.0.0";
	
	public void OnGet()
	{
		Version = settings.Value.Version;
	}
}