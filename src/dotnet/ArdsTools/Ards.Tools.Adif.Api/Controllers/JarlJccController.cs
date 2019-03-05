using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/JarlJcc")]
    [ApiController]
    public class JarlJccController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public JarlJccController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/JarlJcc
        [HttpGet]
        public async Task<ActionResult<IEnumerable<JarlJcc>>> GetJarlJcc()
        {
            return await _context.JarlJcc.ToListAsync();
        }

        // GET: api/JarlJcc/5
        [HttpGet("{id}")]
        public async Task<ActionResult<JarlJcc>> GetJarlJcc(int id)
        {
            var jarlJcc = await _context.JarlJcc.FindAsync(id);

            if (jarlJcc == null)
            {
                return NotFound();
            }

            return jarlJcc;
        }

        // PUT: api/JarlJcc/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutJarlJcc(int id, JarlJcc jarlJcc)
        {
            if (id != jarlJcc.Id)
            {
                return BadRequest();
            }

            _context.Entry(jarlJcc).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!JarlJccExists(id))
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

        // POST: api/JarlJcc
        [HttpPost]
        public async Task<ActionResult<JarlJcc>> PostJarlJcc(JarlJcc jarlJcc)
        {
            _context.JarlJcc.Add(jarlJcc);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetJarlJcc", new { id = jarlJcc.Id }, jarlJcc);
        }

        // DELETE: api/JarlJcc/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<JarlJcc>> DeleteJarlJcc(int id)
        {
            var jarlJcc = await _context.JarlJcc.FindAsync(id);
            if (jarlJcc == null)
            {
                return NotFound();
            }

            _context.JarlJcc.Remove(jarlJcc);
            await _context.SaveChangesAsync();

            return jarlJcc;
        }

        private bool JarlJccExists(int id)
        {
            return _context.JarlJcc.Any(e => e.Id == id);
        }
    }
}
