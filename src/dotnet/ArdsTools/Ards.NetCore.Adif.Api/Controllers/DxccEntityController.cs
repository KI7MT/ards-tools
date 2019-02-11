using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/DxccEntity")]
    [ApiController]
    public class DxccEntityController : ControllerBase
    {
        private readonly AdifContext _context;

        public DxccEntityController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/DxccEntity
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DxccEntity>>> GetDxccEntity()
        {
            return await _context.DxccEntity.ToListAsync();
        }

        // GET: api/DxccEntity/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DxccEntity>> GetDxccEntity(int id)
        {
            var dxccEntity = await _context.DxccEntity.FindAsync(id);

            if (dxccEntity == null)
            {
                return NotFound();
            }

            return dxccEntity;
        }

        // PUT: api/DxccEntity/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDxccEntity(int id, DxccEntity dxccEntity)
        {
            if (id != dxccEntity.Id)
            {
                return BadRequest();
            }

            _context.Entry(dxccEntity).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DxccEntityExists(id))
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

        // POST: api/DxccEntity
        [HttpPost]
        public async Task<ActionResult<DxccEntity>> PostDxccEntity(DxccEntity dxccEntity)
        {
            _context.DxccEntity.Add(dxccEntity);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (DxccEntityExists(dxccEntity.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetDxccEntity", new { id = dxccEntity.Id }, dxccEntity);
        }

        // DELETE: api/DxccEntity/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<DxccEntity>> DeleteDxccEntity(int id)
        {
            var dxccEntity = await _context.DxccEntity.FindAsync(id);
            if (dxccEntity == null)
            {
                return NotFound();
            }

            _context.DxccEntity.Remove(dxccEntity);
            await _context.SaveChangesAsync();

            return dxccEntity;
        }

        private bool DxccEntityExists(int id)
        {
            return _context.DxccEntity.Any(e => e.Id == id);
        }
    }
}
