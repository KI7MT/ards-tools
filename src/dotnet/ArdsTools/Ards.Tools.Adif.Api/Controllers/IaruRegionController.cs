using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/IaruRegion")]
    [ApiController]
    public class IaruRegionController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public IaruRegionController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/IaruRegion
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IaruRegion>>> GetIaruRegion()
        {
            return await _context.IaruRegion.ToListAsync();
        }

        // GET: api/IaruRegion/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IaruRegion>> GetIaruRegion(int id)
        {
            var iaruRegion = await _context.IaruRegion.FindAsync(id);

            if (iaruRegion == null)
            {
                return NotFound();
            }

            return iaruRegion;
        }

        // PUT: api/IaruRegion/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIaruRegion(int id, IaruRegion iaruRegion)
        {
            if (id != iaruRegion.Id)
            {
                return BadRequest();
            }

            _context.Entry(iaruRegion).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IaruRegionExists(id))
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

        // POST: api/IaruRegion
        [HttpPost]
        public async Task<ActionResult<IaruRegion>> PostIaruRegion(IaruRegion iaruRegion)
        {
            _context.IaruRegion.Add(iaruRegion);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (IaruRegionExists(iaruRegion.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetIaruRegion", new { id = iaruRegion.Id }, iaruRegion);
        }

        // DELETE: api/IaruRegion/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IaruRegion>> DeleteIaruRegion(int id)
        {
            var iaruRegion = await _context.IaruRegion.FindAsync(id);
            if (iaruRegion == null)
            {
                return NotFound();
            }

            _context.IaruRegion.Remove(iaruRegion);
            await _context.SaveChangesAsync();

            return iaruRegion;
        }

        private bool IaruRegionExists(int id)
        {
            return _context.IaruRegion.Any(e => e.Id == id);
        }
    }
}
