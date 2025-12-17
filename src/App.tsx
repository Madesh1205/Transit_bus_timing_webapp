import { useState, useEffect } from 'react';
import { createClient } from '@supabase/supabase-js';
import { Bus, MapPin, Clock } from 'lucide-react';

const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
);

interface BusService {
  id: string;
  bus_name: string;
  route: string;
}

interface BusTiming {
  id: string;
  stop: string;
  time: string;
  runs_daily: boolean;
  bus_service_id: string;
}

function App() {
  const [services, setServices] = useState<BusService[]>([]);
  const [timings, setTimings] = useState<BusTiming[]>([]);
  const [selectedService, setSelectedService] = useState<string>('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [servicesRes, timingsRes] = await Promise.all([
        supabase.from('bus_services').select('*'),
        supabase.from('bus_timings').select('*').eq('status', 'approved')
      ]);

      if (servicesRes.error) {
        console.error('Services error:', servicesRes.error);
      } else if (servicesRes.data) {
        setServices(servicesRes.data);
        if (servicesRes.data?.[0]) {
          setSelectedService(servicesRes.data[0].id);
        }
      }

      if (timingsRes.error) {
        console.error('Timings error:', timingsRes.error);
      } else if (timingsRes.data) {
        setTimings(timingsRes.data);
      }
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  };

  const selectedBusData = services.find(s => s.id === selectedService);
  const filteredTimings = selectedService
    ? timings.filter(t => t.bus_service_id === selectedService)
    : [];

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center">
        <div className="text-center">
          <Bus className="w-12 h-12 text-blue-600 mx-auto mb-4 animate-pulse" />
          <p className="text-gray-700">Loading bus timings...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-4 sm:p-6">
      <div className="max-w-4xl mx-auto">
        <div className="mb-8">
          <div className="flex items-center gap-3 mb-2">
            <Bus className="w-8 h-8 text-blue-600" />
            <h1 className="text-3xl sm:text-4xl font-bold text-gray-900">Bus Timings</h1>
          </div>
          <p className="text-gray-600">Find departure times for all bus services</p>
        </div>

        <div className="bg-white rounded-lg shadow-lg p-6 mb-6">
          <label className="block text-sm font-semibold text-gray-700 mb-3">
            Select a Bus Service
          </label>
          <select
            value={selectedService}
            onChange={(e) => setSelectedService(e.target.value)}
            className="w-full px-4 py-3 border-2 border-gray-200 rounded-lg focus:outline-none focus:border-blue-500 transition-colors"
          >
            {services.map(service => (
              <option key={service.id} value={service.id}>
                {service.bus_name} - {service.route}
              </option>
            ))}
          </select>
        </div>

        {selectedBusData && (
          <div className="mb-6 bg-blue-50 border-l-4 border-blue-600 p-4 rounded">
            <p className="text-gray-700">
              <span className="font-semibold text-gray-900">{selectedBusData.bus_name}</span>
              <span className="text-gray-600 mx-2">•</span>
              <span className="text-gray-600">Route: {selectedBusData.route}</span>
            </p>
          </div>
        )}

        <div className="space-y-3">
          {filteredTimings.length > 0 ? (
            filteredTimings.map(timing => (
              <div
                key={timing.id}
                className="bg-white rounded-lg shadow hover:shadow-md transition-shadow p-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3"
              >
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-1">
                    <MapPin className="w-4 h-4 text-blue-600" />
                    <p className="font-semibold text-gray-900">{timing.stop}</p>
                  </div>
                  <p className="text-sm text-gray-500">
                    {timing.runs_daily ? 'Runs Daily' : 'Selected Days'}
                  </p>
                </div>
                <div className="flex items-center gap-2 bg-blue-50 px-4 py-2 rounded-lg">
                  <Clock className="w-4 h-4 text-blue-600" />
                  <p className="font-bold text-blue-600">{timing.time}</p>
                </div>
              </div>
            ))
          ) : (
            <div className="bg-white rounded-lg shadow p-8 text-center">
              <Bus className="w-12 h-12 text-gray-300 mx-auto mb-3" />
              <p className="text-gray-500">No timings available for this service</p>
            </div>
          )}
        </div>

        <div className="mt-8 text-center text-sm text-gray-600">
          <p>Total Bus Services: {services.length}</p>
        </div>
      </div>
    </div>
  );
}

export default App;
