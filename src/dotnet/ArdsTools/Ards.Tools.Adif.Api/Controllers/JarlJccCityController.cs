using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/JarlJccCity")]
    [ApiController]
    public class JarlJccCityController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public JarlJccCityController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/JarlJccCity
        [HttpGet]
        public async Task<ActionResult<IEnumerable<JarlJccCity>>> GetJarlJccCity()
        {
            return await _context.JarlJccCity.ToListAsync();
        }

        // GET: api/JarlJccCity/5
        [HttpGet("{id}")]
        public async Task<ActionResult<JarlJccCity>> GetJarlJccCity(int id)
        {
            var jarlJccCity = await _context.JarlJccCity.FindAsync(id);

            if (jarlJccCity == null)
            {
                return NotFound();
            }

            return jarlJccCity;
        }

        // PUT: api/JarlJccCity/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutJarlJccCity(int id, JarlJccCity jarlJccCity)
        {
            if (id != jarlJccCity.Id)
            {
                return BadRequest();
            }

            _context.Entry(jarlJccCity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!JarlJccCityExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/JarlJccCity
        [HttpPost]
        public async Task<ActionResult<JarlJccCity>> PostJarlJccCity(JarlJccCity jarlJccCity)
        {
            _context.JarlJccCity.Add(jarlJccCity);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetJarlJccCity", new { id = jarlJccCity.Id }, jarlJccCity);
        }

        // DELETE: api/JarlJccCity/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<JarlJccCity>> DeleteJarlJccCity(int id)
        {
            var jarlJccCity = await _context.JarlJccCity.FindAsync(id);
            if (jarlJccCity == null)
            {
                return NotFound();
            }

            _context.JarlJccCity.Remove(jarlJccCity);
            await _context.SaveChangesAsync();

            return jarlJccCity;
        }

        private bool JarlJccCityExists(int id)
        {
            return _context.JarlJccCity.Any(e => e.Id == id);
        }
    }
}
