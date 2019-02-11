using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QslVia")]
    [ApiController]
    public class QslViaController : ControllerBase
    {
        private readonly AdifContext _context;

        public QslViaController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QslVia
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QslVia>>> GetQslVia()
        {
            return await _context.QslVia.ToListAsync();
        }

        // GET: api/QslVia/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QslVia>> GetQslVia(int id)
        {
            var qslVia = await _context.QslVia.FindAsync(id);

            if (qslVia == null)
            {
                return NotFound();
            }

            return qslVia;
        }

        // PUT: api/QslVia/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQslVia(int id, QslVia qslVia)
        {
            if (id != qslVia.Id)
            {
                return BadRequest();
            }

            _context.Entry(qslVia).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QslViaExists(id))
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

        // POST: api/QslVia
        [HttpPost]
        public async Task<ActionResult<QslVia>> PostQslVia(QslVia qslVia)
        {
            _context.QslVia.Add(qslVia);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQslVia", new { id = qslVia.Id }, qslVia);
        }

        // DELETE: api/QslVia/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QslVia>> DeleteQslVia(int id)
        {
            var qslVia = await _context.QslVia.FindAsync(id);
            if (qslVia == null)
            {
                return NotFound();
            }

            _context.QslVia.Remove(qslVia);
            await _context.SaveChangesAsync();

            return qslVia;
        }

        private bool QslViaExists(int id)
        {
            return _context.QslVia.Any(e => e.Id == id);
        }
    }
}
