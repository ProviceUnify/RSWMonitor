﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RSWMonitor.MainApp.Models;
using System.Data;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;

        private Models.Configuration configurations = new Models.Configuration();
        //private ConfigurationTypes configurationTypes = new ConfigurationTypes();
        public ManageRemoteMonitorsController(HealthChecksDBContext HCContext, RoleManager<IdentityRole> roleManager)
        {
            HealthChecksDbContext = HCContext;
            _roleManager = roleManager;
        }
        public async Task<IActionResult> Index(string failure = "", int top = 50)
        {
            List<Models.Configuration>? configurations = HealthChecksDbContext.Configurations?.Include(m => m.Components).ToList();

            // deleting predefined system roles from list
            List<ComponentType>? componentTypes = HealthChecksDbContext.ComponentTypes?.ToList();

            try
            {
                List<IdentityRole> Roles = await _roleManager.Roles.ToListAsync();
                var healthManagerRoleToDelete = await _roleManager.FindByNameAsync("Health manager");
                var userManagerRoleToDelete = await _roleManager.FindByNameAsync("User manager");
                Roles.Remove(healthManagerRoleToDelete);
                Roles.Remove(userManagerRoleToDelete);
                ViewBag.Roles = Roles;
            }
            catch { }

            ViewBag.ComponentTypes = componentTypes;
            ViewBag.failure = failure;

            return View(configurations);
        }

        [HttpPost]
        public async Task<RedirectToActionResult> AddConfiguration(IFormCollection formCollection)
        {
            int componentsCount = Int32.Parse(formCollection["components-count"]);
            List<Component> components = new List<Component>();
            var configurationBaseData = new
            {
                id = Int32.Parse(formCollection["configuration-db-id"]),
                name = formCollection["configuration-name"],
                uri = formCollection["configuration-uri"]
            };

            try
            {
                for (int i = 0; i < componentsCount; i++)
                {
                    int indexOfFormInput = i + 1;
                    int componentId = Int32.Parse(formCollection[$"component-db-id-row-{indexOfFormInput}"]);
                    string componentName = formCollection[$"{{'prop':'component-name','row':{indexOfFormInput}}}"];
                    string componentQuery = formCollection[$"{{'prop':'component-query','row':{indexOfFormInput}}}"];
                    string componentRoletags = formCollection[$"{{'prop':'role','row':{indexOfFormInput}}}"];
                    //componentName = componentName.Trim();
                    int componentTypeId = Int32.Parse(formCollection[$"{{'prop':'component-type','row':{indexOfFormInput}}}"]);
                    if (componentName == "" || componentQuery == "" || componentRoletags == "")
                    {
                        return RedirectToAction("Index", routeValues: new { failure = $"Entered data of component was incorrect" });
                    }
                    List<string> rolesList;
                    try
                    {
                        rolesList = componentRoletags.Split(',').ToList();
                        componentRoletags = JsonConvert.SerializeObject(rolesList);

                    } catch (Exception ex)
                    {

                        componentRoletags = JsonConvert.SerializeObject(new List<string>());
                        //return RedirectToAction("Index", routeValues: new { failure = ex.Message });
                    }

                    if (componentId < 0)
                        componentId = 0;
                    components.Add(new Component
                    {
                        Id = componentId,
                        ComponentName = componentName,
                        ComponentQuery = componentQuery,
                        ComponentTypesId = componentTypeId,
                        ComponentRoletags = componentRoletags,

                        ComponentHasControls = false
                    });
                }
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", routeValues: new { failure = $"{ex.Message}" });
            }

            if (configurationBaseData.name == "" && configurationBaseData.uri == "")
            {
                return RedirectToAction("Index", routeValues: new { failure = $"Entered data of configuration was incorrect" });
            }
            //var configurationRoles = JsonConvert.SerializeObject(components);
            if (configurationBaseData.id < 0)
            {
                Models.Configuration configurations = new Models.Configuration
                {
                    Name = configurationBaseData.name,
                    Uri = configurationBaseData.uri,
                    Components = components

                };
                HealthChecksDbContext.Configurations.Add(configurations);
            }
            else
            {
                Models.Configuration? configurationToEdit = new Models.Configuration();
                configurationToEdit = await HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationBaseData.id).FirstOrDefaultAsync();
                configurationToEdit.Name = configurationBaseData.name;
                configurationToEdit.Uri = configurationBaseData.uri;
                configurationToEdit.Components = components;
            }
            HealthChecksDbContext.SaveChanges();
            return RedirectToAction("Index", routeValues: new { failure = "" });
        }

        [HttpPost]
        public IActionResult RemoveConfiguration(int configurationId = -1)
        {
            try
            {
                if (configurationId >= 0)
                {
                    Models.Configuration? configurationToDelete = new Models.Configuration();
                    configurationToDelete = HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationId).FirstOrDefault();
                    HealthChecksDbContext.Configurations?.Remove(configurationToDelete!);
                    HealthChecksDbContext.SaveChanges();
                    return Ok();
                    //return RedirectToAction("Index");
                }
                else
                {
                    return BadRequest(Json(new { value = "Role name is empty!" }));
                }
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
    }
}
